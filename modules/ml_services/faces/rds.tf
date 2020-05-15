resource "aws_db_subnet_group" "rds" {
  name       = "${var.platform_instance_id}-faces"
  subnet_ids = ["${var.rds_subnet_id_1}", "${var.rds_subnet_id_2}"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

data "aws_subnet" "rds" {
  id = "${var.rds_subnet_id_1}"
}

resource "aws_security_group" "rds" {
  name_prefix = "${var.platform_instance_id}-faces"
  description = "Access to faces RDS Service"
  vpc_id      = "${data.aws_subnet.rds.vpc_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

data "aws_subnet" "subnet_faces_1" {
  id = "${var.ml_loadbalancer_output["mlservices_subnet_id_1"]}"
}

data "aws_subnet" "subnet_faces_2" {
  id = "${var.ml_loadbalancer_output["mlservices_subnet_id_2"]}"
}

resource "aws_security_group_rule" "rds_allow_servers" {
  security_group_id = "${aws_security_group.rds.id}"
  description       = "Allow Faces Nodes"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"

  cidr_blocks = [
    "${data.aws_subnet.subnet_faces_1.cidr_block}",
    "${data.aws_subnet.subnet_faces_2.cidr_block}",
  ]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "gm-${var.platform_instance_id}-faces-${count.index}"
  cluster_identifier = "${aws_rds_cluster.postgresql.id}"
  engine             = "aurora-postgresql"
  engine_version     = "${var.rds_version}"
  instance_class     = "${var.rds_db_instance_size}"

  copy_tags_to_snapshot = true

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_rds_cluster" "postgresql" {
  apply_immediately         = true
  backup_retention_period   = "${var.rds_backup_retention}"
  cluster_identifier        = "gm-${var.platform_instance_id}-faces"
  database_name             = "faces"
  db_subnet_group_name      = "${aws_db_subnet_group.rds.name}"
  engine                    = "aurora-postgresql"
  engine_version            = "${var.rds_version}"
  final_snapshot_identifier = "GrayMetaPlatform-${var.platform_instance_id}-faces-aurora-final"
  master_password           = "${var.rds_db_password}"
  master_username           = "${var.rds_db_username}"
  port                      = "5432"
  preferred_backup_window   = "${var.rds_backup_window}"
  storage_encrypted         = true
  vpc_security_group_ids    = ["${aws_security_group.rds.id}"]

  snapshot_identifier = "${var.rds_snapshot == "final" ?
    format("GrayMetaPlatform-${var.platform_instance_id}-faces-aurora-final") :
    var.rds_snapshot
  }"

  lifecycle {
    ignore_changes = [
      "storage_encrypted",
      "kms_key_id",
      "snapshot_identifier",
    ]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_appautoscaling_target" "replicas" {
  service_namespace  = "rds"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  resource_id        = "cluster:${aws_rds_cluster.postgresql.id}"
  min_capacity       = 1
  max_capacity       = "${var.rds_asg_max_capacity}"
}

resource "aws_appautoscaling_policy" "replicas" {
  name               = "cpu-auto-scaling"
  service_namespace  = "${aws_appautoscaling_target.replicas.service_namespace}"
  scalable_dimension = "${aws_appautoscaling_target.replicas.scalable_dimension}"
  resource_id        = "${aws_appautoscaling_target.replicas.resource_id}"
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    target_value       = "${var.rds_asg_target_cpu}"
    scale_in_cooldown  = "${var.rds_asg_scalein_cooldown}"
    scale_out_cooldown = "${var.rds_asg_scaleout_cooldown}"
  }
}

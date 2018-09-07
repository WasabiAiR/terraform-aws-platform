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

resource "aws_db_instance" "rds" {
  allocated_storage           = "${var.rds_allocated_storage}"
  storage_type                = "gp2"
  engine                      = "postgres"
  engine_version              = "10.4"
  allow_major_version_upgrade = "false"
  auto_minor_version_upgrade  = "false"
  instance_class              = "${var.rds_db_instance_size}"
  name                        = "faces"
  username                    = "${var.rds_db_username}"
  password                    = "${var.rds_db_password}"
  db_subnet_group_name        = "${aws_db_subnet_group.rds.name}"
  final_snapshot_identifier   = "${var.platform_instance_id}-faces-final"
  vpc_security_group_ids      = ["${aws_security_group.rds.id}"]
  multi_az                    = true

  identifier = "${var.platform_instance_id}-faces"

  apply_immediately       = true
  backup_retention_period = "14"
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:00:00-Mon:03:00"
  storage_encrypted       = true

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

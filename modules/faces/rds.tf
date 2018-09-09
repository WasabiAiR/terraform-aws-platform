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
  allow_major_version_upgrade = "false"
  auto_minor_version_upgrade  = "false"
  db_subnet_group_name        = "${aws_db_subnet_group.rds.name}"
  engine                      = "postgres"
  engine_version              = "10.4"
  final_snapshot_identifier   = "GrayMetaPlatform-${var.platform_instance_id}-faces-final"
  identifier                  = "gm-${var.platform_instance_id}-faces"
  instance_class              = "${var.rds_db_instance_size}"
  multi_az                    = true
  name                        = "faces"
  password                    = "${var.rds_db_password}"

  snapshot_identifier = "${var.rds_snapshot == "final" ?
    format("GrayMetaPlatform-${var.platform_instance_id}-faces-final") :
    var.rds_snapshot
  }"

  storage_encrypted      = true
  storage_type           = "gp2"
  username               = "${var.rds_db_username}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]

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

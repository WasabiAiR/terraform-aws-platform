resource "aws_db_instance" "default" {
  allocated_storage           = "${var.allocated_storage}"
  storage_type                = "gp2"
  engine                      = "postgres"
  engine_version              = "9.6.6"
  auto_minor_version_upgrade  = "false"
  instance_class              = "${var.db_instance_size}"
  name                        = "graymeta"
  username                    = "${var.db_username}"
  password                    = "${var.db_password}"
  db_subnet_group_name        = "${aws_db_subnet_group.default.id}"
  final_snapshot_identifier   = "GrayMetaPlatform-${var.platform_instance_id}-final"
  vpc_security_group_ids      = ["${aws_security_group.rds.id}"]
  storage_encrypted           = "${var.db_storage_encrypted}"
  kms_key_id                  = "${var.db_kms_key_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

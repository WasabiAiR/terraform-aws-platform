resource "aws_db_instance" "default" {
  allocated_storage          = "${var.allocated_storage}"
  storage_type               = "gp2"
  engine                     = "postgres"
  engine_version             = "9.6.9"
  auto_minor_version_upgrade = "false"
  backup_retention_period    = "${var.db_backup_retention}"
  backup_window              = "${var.db_backup_window}"
  instance_class             = "${var.db_instance_size}"
  name                       = "graymeta"
  username                   = "${var.db_username}"
  password                   = "${var.db_password}"
  db_subnet_group_name       = "${aws_db_subnet_group.default.id}"
  final_snapshot_identifier  = "GrayMetaPlatform-${var.platform_instance_id}-final"
  vpc_security_group_ids     = ["${aws_security_group.rds.id}"]
  storage_encrypted          = "${var.db_storage_encrypted}"
  kms_key_id                 = "${var.db_kms_key_id}"
  multi_az                   = "${var.db_multi_az}"
  identifier                 = "gm-${var.platform_instance_id}-platform"

  snapshot_identifier = "${var.db_snapshot == "final" ?
    format("GrayMetaPlatform-${var.platform_instance_id}-final") :
    var.db_snapshot
  }"

  lifecycle {
    ignore_changes = [
      "storage_encrypted",
      "kms_key_id",
      "snapshot_identifier",
      "identifier",
    ]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

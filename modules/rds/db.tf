resource "aws_db_instance" "default" {
    allocated_storage         = 100
    storage_type              = "gp2"
    engine                    = "postgres"
    engine_version            = "9.6.1"
    instance_class            = "${var.db_instance_size}"
    name                      = "graymeta"
    username                  = "${var.db_username}"
    password                  = "${var.db_password}"
    db_subnet_group_name      = "${aws_db_subnet_group.default.id}"
    final_snapshot_identifier = "GrayMetaPlatform-${var.platform_instance_id}-final"
    vpc_security_group_ids    = ["${aws_security_group.rds.id}"]

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
        ApplicationName    = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

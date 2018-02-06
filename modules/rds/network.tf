resource "aws_db_subnet_group" "default" {
  subnet_ids = ["${data.aws_subnet.rds_subnet_1.id}", "${data.aws_subnet.rds_subnet_2.id}"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

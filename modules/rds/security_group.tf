resource "aws_security_group" "rds" {
  description = "Access to RDS Database"
  vpc_id      = "${data.aws_subnet.services_subnet_1.vpc_id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_subnet.services_subnet_1.cidr_block}", "${data.aws_subnet.services_subnet_2.cidr_block}"]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group" "ml_alb" {
  description = "Access to ML ALB"
  vpc_id      = "${data.aws_subnet.subnet_mlservices_1.vpc_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ML-ALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

# Allow all outbound traffic
resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.ml_alb.id}"
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

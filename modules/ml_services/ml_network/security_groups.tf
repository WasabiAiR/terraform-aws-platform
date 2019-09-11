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

# Open connection to statsite server
resource "aws_security_group_rule" "allow_udp_8125" {
  security_group_id = "${var.statsite_nsg}"
  description       = "Allow udp/8125"
  type              = "ingress"
  from_port         = 8125
  to_port           = 8125
  protocol          = "udp"

  cidr_blocks = [
    "${data.aws_subnet.subnet_mlservices_1.cidr_block}",
    "${data.aws_subnet.subnet_mlservices_2.cidr_block}",
  ]
}

# Open connection to statsite server
resource "aws_security_group_rule" "allow_tcp_8125" {
  security_group_id = "${var.statsite_nsg}"
  description       = "Allow tcp/8125"
  type              = "ingress"
  from_port         = 8125
  to_port           = 8125
  protocol          = "tcp"

  cidr_blocks = [
    "${data.aws_subnet.subnet_mlservices_1.cidr_block}",
    "${data.aws_subnet.subnet_mlservices_2.cidr_block}",
  ]
}

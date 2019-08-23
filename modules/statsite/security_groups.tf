resource "aws_security_group" "statsite" {
  description = "Access to statsite nodes"
  vpc_id      = "${data.aws_subnet.subnet_statsite_1.vpc_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-statsite"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.statsite.id}"
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = "${aws_security_group.statsite.id}"
  description       = "Allow ssh"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${split(",", var.ssh_cidr_blocks)}"]
}

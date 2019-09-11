resource "aws_security_group" "ecs" {
  description = "Access to ECS nodes"
  vpc_id      = "${data.aws_subnet.ecs_subnet_1.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_cidr_blocks)}"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

# Opens connection to Graphite/statsite
resource "aws_security_group_rule" "allow_udp_8125" {
  security_group_id = "${var.statsite_nsg}"
  description       = "Allow udp/8125"
  type              = "ingress"
  from_port         = 8125
  to_port           = 8125
  protocol          = "udp"

  cidr_blocks = [
    "${data.aws_subnet.ecs_subnet_1.cidr_block}",
    "${data.aws_subnet.ecs_subnet_2.cidr_block}",
  ]
}

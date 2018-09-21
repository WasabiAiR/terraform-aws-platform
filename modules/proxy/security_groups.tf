resource "aws_security_group" "proxy" {
  description = "Access to proxy nodes"
  vpc_id      = "${data.aws_subnet.subnet_proxy_1.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_cidr_blocks)}"]
  }

  ingress {
    from_port = 3128
    to_port   = 3128
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.subnet_proxy_1.cidr_block}",
      "${data.aws_subnet.subnet_proxy_2.cidr_block}",
      "${var.allowed_cidrs}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-proxy"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

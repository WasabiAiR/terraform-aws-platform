resource "aws_security_group" "services" {
  description = "Access to Services nodes"
  vpc_id      = "${data.aws_subnet.subnet_1.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_cidr_blocks)}"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.public_subnet_1.cidr_block}",
      "${data.aws_subnet.public_subnet_2.cidr_block}",
    ]
  }

  ingress {
    from_port = 7000
    to_port   = 7000
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.public_subnet_1.cidr_block}",
      "${data.aws_subnet.public_subnet_2.cidr_block}",
    ]
  }

  ingress {
    from_port = 7009
    to_port   = 7009
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.public_subnet_1.cidr_block}",
      "${data.aws_subnet.public_subnet_2.cidr_block}",
    ]
  }

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.public_subnet_1.cidr_block}",
      "${data.aws_subnet.public_subnet_2.cidr_block}",
    ]
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
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group" "services_alb" {
  description = "Services ALB Security Group"
  vpc_id      = "${data.aws_subnet.subnet_1.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.platform_access_cidrs)}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.platform_access_cidrs)}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.az1_nat_ip}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.az2_nat_ip}"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.platform_access_cidrs)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ServicesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

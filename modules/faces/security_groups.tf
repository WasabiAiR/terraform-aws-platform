resource "aws_security_group" "faces" {
  description = "Access to faces nodes"
  vpc_id      = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_cidr_blocks)}"]
  }

  ingress {
    from_port = 10336
    to_port   = 10336
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.subnet_faces_1.cidr_block}",
      "${data.aws_subnet.subnet_faces_2.cidr_block}",
    ]
  }

    ingress {
    from_port = 10337
    to_port   = 10337
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.subnet_faces_1.cidr_block}",
      "${data.aws_subnet.subnet_faces_2.cidr_block}",
    ]
  }

    ingress {
    from_port = 10338
    to_port   = 10338
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_subnet.subnet_faces_1.cidr_block}",
      "${data.aws_subnet.subnet_faces_2.cidr_block}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

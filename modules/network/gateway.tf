resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_eip" "nat_gateway_ecs" {
  vpc = true
}

resource "aws_eip" "nat_gateway_services" {
  vpc = true
}

resource "aws_nat_gateway" "ecs" {
  allocation_id = "${aws_eip.nat_gateway_ecs.id}"
  subnet_id     = "${aws_subnet.public_1.id}"
  depends_on    = ["aws_internet_gateway.main"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_nat_gateway" "services" {
  allocation_id = "${aws_eip.nat_gateway_services.id}"
  subnet_id     = "${aws_subnet.public_1.id}"
  depends_on    = ["aws_internet_gateway.main"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

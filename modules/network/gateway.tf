resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_eip" "nat_gateway_az1" {
  vpc = true
}

resource "aws_eip" "nat_gateway_az2" {
  vpc = true
}

resource "aws_nat_gateway" "az1" {
  allocation_id = "${aws_eip.nat_gateway_az1.id}"
  subnet_id     = "${aws_subnet.public_1.id}"
  depends_on    = ["aws_internet_gateway.main"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_nat_gateway" "az2" {
  allocation_id = "${aws_eip.nat_gateway_az2.id}"
  subnet_id     = "${aws_subnet.public_2.id}"
  depends_on    = ["aws_internet_gateway.main"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_vpc_endpoint" "proxy_s3" {
  vpc_id            = "${aws_vpc.main.id}"
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = ["${aws_route_table.az1.id}", "${aws_route_table.az2.id}"]
}

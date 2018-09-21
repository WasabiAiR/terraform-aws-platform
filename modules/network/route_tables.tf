resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Default"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Main"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_route_table" "az1" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.az1.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_route_table" "az2" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.az2.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = "${aws_subnet.public_1.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = "${aws_subnet.public_2.id}"
  route_table_id = "${aws_route_table.main.id}"
}

# resource "aws_route_table_association" "ecs" {
#   subnet_id      = "${aws_subnet.ecs.id}"
#   route_table_id = "${aws_route_table.az1.id}"
# }

# resource "aws_route_table_association" "services_1" {
#   subnet_id      = "${aws_subnet.services_1.id}"
#   route_table_id = "${aws_route_table.az1.id}"
# }

# resource "aws_route_table_association" "services_2" {
#   subnet_id      = "${aws_subnet.services_2.id}"
#   route_table_id = "${aws_route_table.az2.id}"
# }

# resource "aws_route_table_association" "rds_1" {
#   subnet_id      = "${aws_subnet.rds_1.id}"
#   route_table_id = "${aws_route_table.az1.id}"
# }

# resource "aws_route_table_association" "rds_2" {
#   subnet_id      = "${aws_subnet.rds_2.id}"
#   route_table_id = "${aws_route_table.az2.id}"
# }

# resource "aws_route_table_association" "elasticsearch_1" {
#   subnet_id      = "${aws_subnet.elasticsearch_1.id}"
#   route_table_id = "${aws_route_table.az1.id}"
# }

# resource "aws_route_table_association" "elasticsearch_2" {
#   subnet_id      = "${aws_subnet.elasticsearch_2.id}"
#   route_table_id = "${aws_route_table.az2.id}"
# }

# resource "aws_route_table_association" "faces_1" {
#   subnet_id      = "${aws_subnet.faces_1.id}"
#   route_table_id = "${aws_route_table.az1.id}"
# }

# resource "aws_route_table_association" "faces_2" {
#   subnet_id      = "${aws_subnet.faces_2.id}"
#   route_table_id = "${aws_route_table.az2.id}"
# }

resource "aws_route_table_association" "proxy_1" {
  subnet_id      = "${aws_subnet.proxy_1.id}"
  route_table_id = "${aws_route_table.az1.id}"
}

resource "aws_route_table_association" "proxy_2" {
  subnet_id      = "${aws_subnet.proxy_2.id}"
  route_table_id = "${aws_route_table.az2.id}"
}

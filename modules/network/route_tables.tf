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

resource "aws_route_table" "ecs" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ecs.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_route_table" "services" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.services.id}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
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

resource "aws_route_table_association" "ecs" {
  subnet_id      = "${aws_subnet.ecs.id}"
  route_table_id = "${aws_route_table.ecs.id}"
}

resource "aws_route_table_association" "services_1" {
  subnet_id      = "${aws_subnet.services_1.id}"
  route_table_id = "${aws_route_table.services.id}"
}

resource "aws_route_table_association" "services_2" {
  subnet_id      = "${aws_subnet.services_2.id}"
  route_table_id = "${aws_route_table.services.id}"
}

resource "aws_route_table_association" "rds_1" {
  subnet_id      = "${aws_subnet.rds_1.id}"
  route_table_id = "${aws_route_table.services.id}"
}

resource "aws_route_table_association" "rds_2" {
  subnet_id      = "${aws_subnet.rds_2.id}"
  route_table_id = "${aws_route_table.services.id}"
}

resource "aws_route_table_association" "elasticsearch_1" {
  subnet_id      = "${aws_subnet.elasticsearch_1.id}"
  route_table_id = "${aws_route_table.services.id}"
}

resource "aws_route_table_association" "elasticsearch_2" {
  subnet_id      = "${aws_subnet.elasticsearch_2.id}"
  route_table_id = "${aws_route_table.services.id}"
}

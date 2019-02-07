resource "aws_subnet" "public_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_public_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Public1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_public_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Public2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "rds_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_rds_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "rds_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_rds_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "services_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_services_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "services_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_services_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "ecs" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_ecs_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "ecs_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_ecs_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "elasticsearch_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_elasticsearch_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Elasticsearch1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "elasticsearch_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_elasticsearch_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Elasticsearch2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "faces_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_mlservices_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLservices1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "faces_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_mlservices_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLservices2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "proxy_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_proxy_1}"
  availability_zone = "${var.az1}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_subnet" "proxy_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_subnet_proxy_2}"
  availability_zone = "${var.az2}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

data "aws_subnet" "subnet_proxy_1" {
  id = "${var.proxy_subnet_id_1}"
}

data "aws_subnet" "subnet_proxy_2" {
  id = "${var.proxy_subnet_id_2}"
}

data "aws_region" "current" {}

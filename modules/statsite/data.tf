data "aws_subnet" "subnet_statsite_1" {
  id = "${var.statsite_subnet_id_1}"
}

data "aws_region" "current" {}

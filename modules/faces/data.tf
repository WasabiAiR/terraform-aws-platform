data "aws_subnet" "subnet_faces_1" {
  id = "${var.faces_subnet_id_1}"
}

data "aws_subnet" "subnet_faces_2" {
  id = "${var.faces_subnet_id_2}"
}

data "aws_region" "current" {}

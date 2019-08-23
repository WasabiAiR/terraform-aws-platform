data "aws_subnet" "subnet_mlservices_1" {
  id = "${var.mlservices_subnet_id_1}"
}

data "aws_subnet" "subnet_mlservices_2" {
  id = "${var.mlservices_subnet_id_2}"
}

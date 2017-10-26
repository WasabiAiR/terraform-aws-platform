variable "platform_instance_id" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "instance_type_services" {}
variable "instance_type_facebox" {}

data "aws_subnet" "subnet_1" {
  id = "${var.subnet_id_1}"
}

data "aws_subnet" "subnet_2" {
  id = "${var.subnet_id_2}"
}

variable "platform_instance_id" {}
variable "rds_subnet_id_1" {}
variable "rds_subnet_id_2" {}
variable "services_subnet_id_1" {}
variable "services_subnet_id_2" {}

variable "db_username" {}
variable "db_password" {}
variable "db_instance_size" {}

variable "allocated_storage" {}

data "aws_subnet" "rds_subnet_1" {
  id = "${var.rds_subnet_id_1}"
}

data "aws_subnet" "rds_subnet_2" {
  id = "${var.rds_subnet_id_2}"
}

data "aws_subnet" "services_subnet_1" {
  id = "${var.services_subnet_id_1}"
}

data "aws_subnet" "services_subnet_2" {
  id = "${var.services_subnet_id_2}"
}

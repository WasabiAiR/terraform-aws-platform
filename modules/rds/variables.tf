# Required

variable "allocated_storage" {}
variable "db_backup_retention" {}
variable "db_backup_window" {}
variable "db_instance_size" {}
variable "db_kms_key_id" {}
variable "db_multi_az" {}
variable "db_password" {}
variable "db_snapshot" {}
variable "db_storage_encrypted" {}
variable "db_username" {}
variable "platform_instance_id" {}
variable "rds_subnet_id_1" {}
variable "rds_subnet_id_2" {}
variable "services_subnet_id_1" {}
variable "services_subnet_id_2" {}

# Data Source

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

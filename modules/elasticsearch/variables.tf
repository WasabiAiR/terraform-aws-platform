# Required

variable "dedicated_master_count" {}
variable "dedicated_master_type" {}
variable "instance_count" {}
variable "instance_type" {}
variable "platform_instance_id" {}
variable "region" {}
variable "security_group_ids" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "volume_size" {}

# Data Source

data "aws_caller_identity" "current" {}

data "aws_subnet" "subnet_1" {
  id = "${var.subnet_id_1}"
}

data "aws_subnet" "subnet_2" {
  id = "${var.subnet_id_2}"
}

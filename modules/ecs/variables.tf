variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "max_cluster_size" {}
variable "min_cluster_size" {}
variable "platform_instance_id" {}
variable "proxy_endpoint" {}
variable "region" {}
variable "ssh_cidr_blocks" {}
variable "statsite_nsg" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "user_init" {}
variable "volume_size" {}

data "aws_subnet" "ecs_subnet_1" {
  id = "${var.subnet_id_1}"
}

data "aws_subnet" "ecs_subnet_2" {
  id = "${var.subnet_id_2}"
}

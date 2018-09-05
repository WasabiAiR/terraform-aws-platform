variable "region" {}
variable "platform_instance_id" {}
variable "subnet_id" {}
variable "instance_type" {}
variable "ami_id" {}
variable "max_cluster_size" {}
variable "min_cluster_size" {}
variable "key_name" {}
variable "volume_size" {}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks to allow SSH access from."
}

variable "user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered"
  default     = ""
}

data "aws_subnet" "ecs_subnet" {
  id = "${var.subnet_id}"
}

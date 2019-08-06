variable "instance_type" {
  type        = "string"
  description = "ec2 instance type"
}

variable "max_cluster_size" {
  type        = "string"
  description = "The max number of ec2 instances to spin up"
}

variable "min_cluster_size" {
  type        = "string"
  description = "The max number of ec2 instances to spin up"
}

variable "ml_loadbalancer_output" {
  type        = "map"
  description = "The output from the ml_network module"
}

variable "services_ecs_cidrs" {
  type        = "list"
  description = "The list of cidrs to allow connection to cluster"
}

variable "user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on cluster instances. (Not Recommened)"
  default     = ""
}

variable "volume_size" {
  type        = "string"
  description = "The OS disk size for credits Server"
  default     = "50"
}

data "aws_region" "current" {}

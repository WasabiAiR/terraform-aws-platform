variable "customer" {}
variable "platform_instance_id" {}
variable "platform_access_cidrs" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "public_subnet_id_1" {}
variable "public_subnet_id_2" {}
variable "ecs_nat_ip" {}
variable "services_nat_ip" {}
variable "ssl_certificate_arn" {}
variable "file_storage_s3_bucket_arn" {}
variable "usage_s3_bucket_arn" {}
variable "ami_id" {}
variable "instance_type" {}
variable "max_cluster_size" {}
variable "min_cluster_size" {}
variable "key_name" {}
variable "client_secret_fe" {}
variable "client_secret_internal" {}
variable "dns_name" {}
variable "ecs_cluster" {}
variable "elasticache_facebox" {}
variable "elasticache_services" {}
variable "elasticsearch_endpoint" {}
variable "encryption_key" {}
variable "facebox_key" {}
variable "jwt_key" {}
variable "encrypted_config_blob" {}
variable "services_iam_role_name" {}

# SES Information
variable "notifications_from_addr" {}

# SQS Queue Information
variable "sqs_activity" {}
variable "sqs_activity_arn" {}
variable "sqs_index" {}
variable "sqs_index_arn" {}
variable "sqs_stage" {}
variable "sqs_stage_arn" {}
variable "sqs_walk" {}
variable "sqs_walk_arn" {}

# RDS
variable "db_username" {}
variable "db_password" {}
variable "db_endpoint" {}

variable "box_client_id" {}
variable "box_client_secret" {}
variable "google_maps_key" {}
variable "rollbar_token" {}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks to allow SSH access from."
}

data "aws_region" "current" {
  current = true
}

data "aws_subnet" "subnet_1" {
  id = "${var.subnet_id_1}"
}

data "aws_subnet" "subnet_2" {
  id = "${var.subnet_id_2}"
}

data "aws_subnet" "public_subnet_1" {
  id = "${var.public_subnet_id_1}"
}

data "aws_subnet" "public_subnet_2" {
  id = "${var.public_subnet_id_2}"
}

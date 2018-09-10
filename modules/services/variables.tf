variable "region" {}
variable "customer" {}
variable "platform_instance_id" {}
variable "platform_access_cidrs" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "public_subnet_id_1" {}
variable "public_subnet_id_2" {}
variable "az1_nat_ip" {}
variable "az2_nat_ip" {}
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
variable "ecs_cpu_reservation" {}
variable "ecs_memory_hard_reservation" {}
variable "ecs_memory_soft_reservation" {}
variable "elasticache_facebox" {}
variable "elasticache_services" {}
variable "elasticsearch_endpoint" {}
variable "encryption_key" {}
variable "facebox_key" {}
variable "faces_endpoint" {}
variable "jwt_key" {}
variable "encrypted_config_blob" {}
variable "log_retention" {}
variable "services_iam_role_name" {}
variable "temporary_bucket_name" {}
variable "harvest_polling_time" {}
variable "harvest_complete_stow_fields" {}

variable "notifications_from_addr" {}

variable "sqs_activity" {}
variable "sqs_activity_arn" {}
variable "sqs_index" {}
variable "sqs_index_arn" {}
variable "sqs_stage01" {}
variable "sqs_stage02" {}
variable "sqs_stage03" {}
variable "sqs_stage04" {}
variable "sqs_stage05" {}
variable "sqs_stage06" {}
variable "sqs_stage07" {}
variable "sqs_stage08" {}
variable "sqs_stage09" {}
variable "sqs_stage10" {}
variable "sqs_stage01_arn" {}
variable "sqs_stage02_arn" {}
variable "sqs_stage03_arn" {}
variable "sqs_stage04_arn" {}
variable "sqs_stage05_arn" {}
variable "sqs_stage06_arn" {}
variable "sqs_stage07_arn" {}
variable "sqs_stage08_arn" {}
variable "sqs_stage09_arn" {}
variable "sqs_stage10_arn" {}
variable "sqs_walk" {}
variable "sqs_walk_arn" {}

variable "sqs_s3notifications_arn" {}
variable "sqs_s3notifications" {}
variable "s3subscriber_priority" {}

variable "db_username" {}
variable "db_password" {}
variable "db_endpoint" {}

variable "google_maps_key" {}
variable "rollbar_token" {}

variable "gm_walkd_max_item_concurrency" {
  default = "600"
}

variable "gm_walkd_redis_max_active" {
  default = "1200"
}

variable "walkd_item_batch_size" {
  default = "300"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks to allow SSH access from."
}

variable "user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered"
  default     = ""
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

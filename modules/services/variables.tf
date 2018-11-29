variable "account_lockout_attempts" {}
variable "account_lockout_interval" {}
variable "account_lockout_period" {}
variable "ami_id" {}
variable "az1_nat_ip" {}
variable "az2_nat_ip" {}
variable "bcrypt_cost" {}
variable "box_com_client_id" {}
variable "box_com_secret_key" {}
variable "client_secret_fe" {}
variable "client_secret_internal" {}
variable "customer" {}
variable "db_endpoint" {}
variable "db_password" {}
variable "db_username" {}
variable "dns_name" {}
variable "dropbox_app_key" {}
variable "dropbox_app_secret" {}
variable "ecs_cluster" {}
variable "ecs_cpu_reservation" {}
variable "ecs_memory_hard_reservation" {}
variable "ecs_memory_soft_reservation" {}
variable "elasticache_services" {}
variable "elasticsearch_endpoint" {}
variable "encrypted_config_blob" {}
variable "encryption_key" {}
variable "faces_endpoint" {}
variable "file_storage_s3_bucket_arn" {}
variable "gm_jwt_expiration_time" {}
variable "gm_threshold_to_harvest" {}
variable "gm_walkd_max_item_concurrency" {}
variable "gm_walkd_redis_max_active" {}
variable "google_maps_key" {}
variable "harvest_complete_stow_fields" {}
variable "harvest_polling_time" {}
variable "instance_type" {}
variable "jwt_key" {}
variable "key_name" {}
variable "log_retention" {}
variable "max_cluster_size" {}
variable "min_cluster_size" {}
variable "notifications_from_addr" {}
variable "notifications_region" {}
variable "password_min_length" {}
variable "platform_access_cidrs" {}
variable "platform_instance_id" {}
variable "proxy_endpoint" {}
variable "public_subnet_id_1" {}
variable "public_subnet_id_2" {}
variable "region" {}
variable "rollbar_token" {}
variable "s3subscriber_priority" {}
variable "services_iam_role_name" {}
variable "sqs_activity" {}
variable "sqs_activity_arn" {}
variable "sqs_index" {}
variable "sqs_index_arn" {}
variable "sqs_s3notifications" {}
variable "sqs_s3notifications_arn" {}
variable "sqs_stage01" {}
variable "sqs_stage01_arn" {}
variable "sqs_stage02" {}
variable "sqs_stage02_arn" {}
variable "sqs_stage03" {}
variable "sqs_stage03_arn" {}
variable "sqs_stage04" {}
variable "sqs_stage04_arn" {}
variable "sqs_stage05" {}
variable "sqs_stage05_arn" {}
variable "sqs_stage06" {}
variable "sqs_stage06_arn" {}
variable "sqs_stage07" {}
variable "sqs_stage07_arn" {}
variable "sqs_stage08" {}
variable "sqs_stage08_arn" {}
variable "sqs_stage09" {}
variable "sqs_stage09_arn" {}
variable "sqs_stage10" {}
variable "sqs_stage10_arn" {}
variable "sqs_walk" {}
variable "sqs_walk_arn" {}
variable "ssh_cidr_blocks" {}
variable "ssl_certificate_arn" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "temporary_bucket_name" {}
variable "usage_s3_bucket_arn" {}
variable "user_init" {}
variable "walkd_item_batch_size" {}

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

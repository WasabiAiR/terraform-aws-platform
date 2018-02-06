variable "customer" {}
variable "platform_instance_id" {}
variable "platform_access_cidrs" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "public_subnet_id_1" {}
variable "public_subnet_id_2" {}
variable "ecs_nat_ip" {}
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

variable "azure_emotion_key" {}
variable "azure_face_api_key" {}
variable "azure_vision_key" {}
variable "geonames_user" {}
variable "google_maps_key" {}
variable "google_speech_auth_json" {}
variable "google_speech_bucket" {}
variable "google_speech_project_id" {}
variable "google_vision_features" {}
variable "google_vision_key" {}
variable "languageid_apptek_host" {}
variable "languageid_apptek_password" {}
variable "languageid_apptek_segment_length" {}
variable "languageid_apptek_username" {}
variable "microsoft_speech_api_key" {}
variable "pic_purify_key" {}
variable "pic_purify_tasks" {}
variable "rollbar_token" {}
variable "safety_dm_host" {}
variable "safety_dm_pass" {}
variable "safety_dm_user" {}
variable "speech_apptek_concurrency" {}
variable "speech_apptek_host" {}
variable "speech_apptek_password" {}
variable "speech_apptek_username" {}
variable "watson_speech_password" {}
variable "watson_speech_username" {}
variable "weather_api_key" {}

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

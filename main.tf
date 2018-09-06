provider "aws" {
  region = "${var.region}"
}

module "ecs" {
  source = "./modules/ecs"

  region               = "${var.region}"
  platform_instance_id = "${var.platform_instance_id}"
  subnet_id            = "${var.ecs_subnet_id}"
  ami_id               = "${lookup(var.ecs_amis, var.region)}"
  instance_type        = "${var.ecs_instance_type}"
  max_cluster_size     = "${var.ecs_max_cluster_size}"
  min_cluster_size     = "${var.ecs_min_cluster_size}"
  key_name             = "${var.key_name}"
  ssh_cidr_blocks      = "${var.ssh_cidr_blocks}"
  volume_size          = "${var.ecs_volume_size}"
  user_init            = "${var.ecs_user_init}"
}

module "queues" {
  source = "./modules/queues"

  platform_instance_id = "${var.platform_instance_id}"
}

module "elasticache" {
  source = "./modules/elasticache"

  platform_instance_id   = "${var.platform_instance_id}"
  subnet_id_1            = "${var.services_subnet_id_1}"
  subnet_id_2            = "${var.services_subnet_id_2}"
  instance_type_services = "${var.elasticache_instance_type_services}"
  instance_type_facebox  = "${var.elasticache_instance_type_facebox}"
}

module "elasticsearch" {
  source = "./modules/elasticsearch"

  platform_instance_id   = "${var.platform_instance_id}"
  region                 = "${var.region}"
  security_group_ids     = "${module.services.services_security_group_id}"
  subnet_id_1            = "${var.elasticsearch_subnet_id_1}"
  subnet_id_2            = "${var.elasticsearch_subnet_id_2}"
  volume_size            = "${var.elasticsearch_volume_size}"
  instance_type          = "${var.elasticsearch_instance_type}"
  instance_count         = "${var.elasticsearch_instance_count}"
  dedicated_master_type  = "${var.elasticsearch_dedicated_master_type}"
  dedicated_master_count = "${var.elasticsearch_dedicated_master_count}"
}

module "rds" {
  source = "./modules/rds"

  platform_instance_id = "${var.platform_instance_id}"
  db_username          = "${var.db_username}"
  db_password          = "${var.db_password}"
  db_snapshot          = "${var.db_snapshot}"
  db_storage_encrypted = "${var.db_storage_encrypted}"
  db_kms_key_id        = "${var.db_kms_key_id}"
  rds_subnet_id_1      = "${var.rds_subnet_id_1}"
  rds_subnet_id_2      = "${var.rds_subnet_id_2}"
  services_subnet_id_1 = "${var.services_subnet_id_1}"
  services_subnet_id_2 = "${var.services_subnet_id_2}"
  db_instance_size     = "${var.db_instance_size}"
  allocated_storage    = "${var.db_allocated_storage}"
}

module "services" {
  source = "./modules/services"

  region                       = "${var.region}"
  customer                     = "${var.customer}"
  platform_instance_id         = "${var.platform_instance_id}"
  az1_nat_ip                   = "${var.az1_nat_ip}"
  az2_nat_ip                   = "${var.az2_nat_ip}"
  platform_access_cidrs        = "${var.platform_access_cidrs}"
  ssh_cidr_blocks              = "${var.ssh_cidr_blocks}"
  subnet_id_1                  = "${var.services_subnet_id_1}"
  subnet_id_2                  = "${var.services_subnet_id_2}"
  public_subnet_id_1           = "${var.public_subnet_id_1}"
  public_subnet_id_2           = "${var.public_subnet_id_2}"
  ssl_certificate_arn          = "${var.ssl_certificate_arn}"
  file_storage_s3_bucket_arn   = "${var.file_storage_s3_bucket_arn}"
  usage_s3_bucket_arn          = "${var.usage_s3_bucket_arn}"
  ami_id                       = "${lookup(var.services_amis, var.region)}"
  instance_type                = "${var.services_instance_type}"
  elasticsearch_endpoint       = "https://${module.elasticsearch.endpoint}"
  max_cluster_size             = "${var.services_max_cluster_size}"
  min_cluster_size             = "${var.services_min_cluster_size}"
  key_name                     = "${var.key_name}"
  notifications_from_addr      = "${var.notifications_from_addr}"
  encrypted_config_blob        = "${var.encrypted_config_blob}"
  log_retention                = "${var.log_retention}"
  services_iam_role_name       = "${var.services_iam_role_name}"
  temporary_bucket_name        = "${module.ecs.temporary_bucket_name}"
  harvest_complete_stow_fields = "${var.harvest_complete_stow_fields}"
  sqs_s3notifications_arn      = "${var.sqs_s3notifications_arn}"
  sqs_s3notifications          = "${var.sqs_s3notifications}"
  s3subscriber_priority        = "${var.s3subscriber_priority}"

  sqs_activity     = "${module.queues.activity}"
  sqs_activity_arn = "${module.queues.activity_arn}"
  sqs_index        = "${module.queues.index}"
  sqs_index_arn    = "${module.queues.index_arn}"
  sqs_stage01      = "${module.queues.stage01}"
  sqs_stage02      = "${module.queues.stage02}"
  sqs_stage03      = "${module.queues.stage03}"
  sqs_stage04      = "${module.queues.stage04}"
  sqs_stage05      = "${module.queues.stage05}"
  sqs_stage06      = "${module.queues.stage06}"
  sqs_stage07      = "${module.queues.stage07}"
  sqs_stage08      = "${module.queues.stage08}"
  sqs_stage09      = "${module.queues.stage09}"
  sqs_stage10      = "${module.queues.stage10}"
  sqs_stage01_arn  = "${module.queues.stage01_arn}"
  sqs_stage02_arn  = "${module.queues.stage02_arn}"
  sqs_stage03_arn  = "${module.queues.stage03_arn}"
  sqs_stage04_arn  = "${module.queues.stage04_arn}"
  sqs_stage05_arn  = "${module.queues.stage05_arn}"
  sqs_stage06_arn  = "${module.queues.stage06_arn}"
  sqs_stage07_arn  = "${module.queues.stage07_arn}"
  sqs_stage08_arn  = "${module.queues.stage08_arn}"
  sqs_stage09_arn  = "${module.queues.stage09_arn}"
  sqs_stage10_arn  = "${module.queues.stage10_arn}"
  sqs_walk         = "${module.queues.walk}"
  sqs_walk_arn     = "${module.queues.walk_arn}"

  db_username = "${var.db_username}"
  db_password = "${var.db_password}"
  db_endpoint = "${module.rds.endpoint}"

  client_secret_fe            = "${var.client_secret_fe}"
  client_secret_internal      = "${var.client_secret_internal}"
  dns_name                    = "${var.dns_name}"
  ecs_cluster                 = "${module.ecs.cluster}"
  ecs_cpu_reservation         = "${var.ecs_cpu_reservation}"
  ecs_memory_hard_reservation = "${var.ecs_memory_hard_reservation}"
  ecs_memory_soft_reservation = "${var.ecs_memory_soft_reservation}"
  elasticache_facebox         = "${module.elasticache.endpoint_facebox}"
  elasticache_services        = "${module.elasticache.endpoint_services}"
  encryption_key              = "${var.encryption_key}"
  facebox_key                 = "${var.facebox_key}"
  harvest_polling_time        = "${var.harvest_polling_time}"
  jwt_key                     = "${var.jwt_key}"

  google_maps_key = "${var.google_maps_key}"
  rollbar_token   = "${var.rollbar_token}"

  user_init = "${var.services_user_init}"
}

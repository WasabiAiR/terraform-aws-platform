provider "aws" {
    region = "${var.region}"
}

module "ecs" {
    source = "./modules/ecs"

    platform_instance_id = "${var.platform_instance_id}"
    subnet_id            = "${var.ecs_subnet_id}"
    ami_id               = "${lookup(var.ecs_amis, var.region)}"
    instance_type        = "${var.ecs_instance_type}"
    max_cluster_size     = "${var.ecs_max_cluster_size}"
    min_cluster_size     = "${var.ecs_min_cluster_size}"
    key_name             = "${var.key_name}"
    ssh_cidr_blocks      = "${var.ssh_cidr_blocks}"
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

module "rds" {
    source = "./modules/rds"

    platform_instance_id = "${var.platform_instance_id}"
    db_username          = "${var.db_username}"
    db_password          = "${var.db_password}"
    rds_subnet_id_1      = "${var.rds_subnet_id_1}"
    rds_subnet_id_2      = "${var.rds_subnet_id_2}"
    services_subnet_id_1 = "${var.services_subnet_id_1}"
    services_subnet_id_2 = "${var.services_subnet_id_2}"
    db_instance_size     = "${var.db_instance_size}"
}

module "services" {
    source = "./modules/services"

    platform_instance_id       = "${var.platform_instance_id}"
    ecs_nat_ip                 = "${var.ecs_nat_ip}"
    platform_access_cidrs      = "${var.platform_access_cidrs}"
    ssh_cidr_blocks            = "${var.ssh_cidr_blocks}"
    subnet_id_1                = "${var.services_subnet_id_1}"
    subnet_id_2                = "${var.services_subnet_id_2}"
    public_subnet_id_1         = "${var.public_subnet_id_1}"
    public_subnet_id_2         = "${var.public_subnet_id_2}"
    ssl_certificate_arn        = "${var.ssl_certificate_arn}"
    file_storage_s3_bucket_arn = "${var.file_storage_s3_bucket_arn}"
    ami_id                     = "${lookup(var.services_amis, var.region)}"
    instance_type              = "${var.services_instance_type}"
    elasticsearch_endpoint     = "${var.elasticsearch_endpoint}"
    max_cluster_size           = "${var.services_max_cluster_size}"
    min_cluster_size           = "${var.services_min_cluster_size}"
    key_name                   = "${var.key_name}"

    sqs_activity          = "${module.queues.activity}"
    sqs_activity_arn      = "${module.queues.activity_arn}"
    sqs_index             = "${module.queues.index}"
    sqs_index_arn         = "${module.queues.index_arn}"
    sqs_stage             = "${module.queues.stage}"
    sqs_stage_arn         = "${module.queues.stage_arn}"
    sqs_walk              = "${module.queues.walk}"
    sqs_walk_arn          = "${module.queues.walk_arn}"

    db_username           = "${var.db_username}"
    db_password           = "${var.db_password}"
    db_endpoint           = "${module.rds.endpoint}"

    client_secret_fe                 = "${var.client_secret_fe}"
    client_secret_internal           = "${var.client_secret_internal}"
    dns_name                         = "${var.dns_name}"
    ecs_cluster                      = "${module.ecs.cluster}"
    elasticache_facebox              = "${module.elasticache.endpoint_facebox}"
    elasticache_services             = "${module.elasticache.endpoint_services}"
    encryption_key                   = "${var.encryption_key}"
    facebox_key                      = "${var.facebox_key}"
    jwt_key                          = "${var.jwt_key}"

    azure_emotion_key                = "${var.azure_emotion_key}"
    azure_face_api_key               = "${var.azure_face_api_key}"
    azure_vision_key                 = "${var.azure_vision_key}"
    geonames_user                    = "${var.geonames_user}"
    google_maps_key                  = "${var.google_maps_key}"
    google_speech_auth_json          = "${var.google_speech_auth_json}"
    google_speech_bucket             = "${var.google_speech_bucket}"
    google_speech_project_id         = "${var.google_speech_project_id}"
    google_vision_features           = "${var.google_vision_features}"
    google_vision_key                = "${var.google_vision_key}"
    languageid_apptek_host           = "${var.languageid_apptek_host}"
    languageid_apptek_password       = "${var.languageid_apptek_password}"
    languageid_apptek_segment_length = "${var.languageid_apptek_segment_length}"
    languageid_apptek_username       = "${var.languageid_apptek_username}"
    microsoft_speech_api_key         = "${var.microsoft_speech_api_key}"
    pic_purify_key                   = "${var.pic_purify_key}"
    pic_purify_tasks                 = "${var.pic_purify_tasks}"
    safety_dm_host                   = "${var.safety_dm_host}"
    safety_dm_pass                   = "${var.safety_dm_pass}"
    safety_dm_user                   = "${var.safety_dm_user}"
    speech_apptek_concurrency        = "${var.speech_apptek_concurrency}"
    speech_apptek_host               = "${var.speech_apptek_host}"
    speech_apptek_password           = "${var.speech_apptek_password}"
    speech_apptek_username           = "${var.speech_apptek_username}"
    watson_speech_password           = "${var.watson_speech_password}"
    watson_speech_username           = "${var.watson_speech_username}"
    weather_api_key                  = "${var.weather_api_key}"
}

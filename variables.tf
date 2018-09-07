variable "region" {
  type        = "string"
  description = "The region to deploy into"
}

variable "customer" {
  type        = "string"
  description = "A human-readable string that identifies your company. Should be alphanumeric + underscores only. eg. If your company is 'XYZ Widgets', you might set it to 'xyzwidgets' or 'xyz_widgets'"
}

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "ecs_subnet_id" {
  type        = "string"
  description = "The subnet ID to use to deploy the ECS cluster into"
}

variable "services_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the services cluster into. Needs to be in a different AZ than services_subnet_id_2"
}

variable "services_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the services cluster into. Needs to be in a different AZ than services_subnet_id_1"
}

variable "rds_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_2"
}

variable "rds_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_1"
}

variable "public_subnet_id_1" {
  type        = "string"
  description = "The first public subnet ID to use. Needs to be in a different AZ than public_subnet_id_2"
}

variable "public_subnet_id_2" {
  type        = "string"
  description = "The second public subnet ID to use. Needs to be in a different AZ than public_subnet_id_1"
}

variable "elasticsearch_subnet_id_1" {
  type        = "string"
  description = "The first elasticsearch subnet ID to use. Needs to be in a different AZ than elasticsearch_subnet_id_2"
}

variable "elasticsearch_subnet_id_2" {
  type        = "string"
  description = "The second elasticsearch subnet ID to use. Needs to be in a different AZ than elasticsearch_subnet_id_1"
}

variable "ecs_cpu_reservation" {
  type        = "string"
  description = "Not recommened to change unless you talk to GrayMeta support.  Default: 1024"
  default     = "1024"
}

variable "ecs_memory_hard_reservation" {
  type        = "string"
  description = "Not recommened to change unless you talk to GrayMeta support.  Default: 4000"
  default     = "4000"
}

variable "ecs_memory_soft_reservation" {
  type        = "string"
  description = "Not recommened to change unless you talk to GrayMeta support.  Default: 3000"
  default     = "3000"
}

variable "ecs_max_cluster_size" {
  type        = "string"
  description = "The maxiumum number of nodes in the ECS cluster"
}

variable "ecs_min_cluster_size" {
  type        = "string"
  description = "The minimum number of nodes in the ECS cluster"
  default     = "1"
}

variable "ecs_volume_size" {
  type        = "string"
  description = "The size of the EBS volumes to mount to ECS nodes. This is workload dependent. Contact GrayMeta for a recommendation"
}

variable "services_max_cluster_size" {
  type        = "string"
  description = "The maxiumum number of nodes in the Services cluster"
}

variable "services_min_cluster_size" {
  type        = "string"
  description = "The minimum number of nodes in the Services cluster"
  default     = "2"
}

variable "ecs_instance_type" {
  type        = "string"
  description = "The Instance Type to use for ECS nodes"
  default     = "c4.large"
}

variable "services_instance_type" {
  type        = "string"
  description = "The Instance Type to use for Services nodes"
  default     = "m4.large"
}

variable "key_name" {
  type        = "string"
  description = "The name of the EC2 keypair to deploy to instances"
}

variable "platform_access_cidrs" {
  type        = "string"
  description = "A comma delimited list of CIDRs from which to allow access to the site."
}

variable "az1_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from az1 is NAT'ed through to allow access to the APIs"
}

variable "az2_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from az2 is NAT'ed through to allow access to the APIs"
}

variable "ssl_certificate_arn" {
  type        = "string"
  description = "The ARN of the SSL certificate to use to secure the endpoints. Must be a valid CA issued certificate (no self-signed certs)"
}

variable "db_password" {
  type        = "string"
  description = "password for postgresql database"
  default     = ""
}

variable "db_username" {
  type        = "string"
  description = "username for postgresql database"
}

variable "db_instance_size" {
  type        = "string"
  description = "The size of the instance to use for the RDS database instance"
  default     = "db.t2.small"
}

variable "db_allocated_storage" {
  type        = "string"
  description = "The size of the storage to allocate for the RDS database, in GB"
  default     = "100"
}

variable "db_snapshot" {
  type        = "string"
  description = "(Optional) Specify a snapshot to use on db create.  For initial install this should be empty string.  After the initial create it is recommended to set this to final."
  default     = ""
}

variable "db_storage_encrypted" {
  type        = "string"
  description = "(Optional) The data is already encrypted by Platform before inserting into database.  This option specifies whether the DB instance is encrypted at rest.  The default is false if not specified"
  default     = false
}

variable "db_kms_key_id" {
  type        = "string"
  description = "(Optional) The ARN for the KMS encryption key.  If not specified and db_storage_encrypted is true, it will generate a kms key"
  default     = ""
}

variable "file_storage_s3_bucket_arn" {
  type        = "string"
  description = "The ARN of the s3 bucket to store thumbnails, video previews, and metadata files"
}

variable "usage_s3_bucket_arn" {
  type        = "string"
  description = "The ARN of the s3 bucket to store usage reports"
}

variable "client_secret_fe" {
  type        = "string"
  description = "32 character string used to generate tokens"
  default     = ""
}

variable "client_secret_internal" {
  type        = "string"
  description = "32 character string used to generate tokens used internally by the system."
  default     = ""
}

variable "dns_name" {
  type        = "string"
  description = "The DNS hostname that will be used to access the plaform (ex. graymeta.example.com)"
}

variable "encryption_key" {
  type        = "string"
  description = "32 Character string used to encrypt data prior to storage in the database"
  default     = ""
}

variable "facebox_key" {
  type        = "string"
  description = "A facebox PRO license key. See http://machinebox.io"
}

variable "faces_endpoint" {
  type        = "string"
  description = "Faces endpoint from the faces module"
  default     = ""
}

variable "google_maps_key" {
  type        = "string"
  description = "A Google maps key"
}

variable "harvest_polling_time" {
  type        = "string"
  description = "Live Harvest Polling time.  Default: 6h"
  default     = "6h"
}

variable "jwt_key" {
  type        = "string"
  description = "A 32 character string used to encrypt JWT web tokens"
  default     = ""
}

variable "elasticache_instance_type_services" {
  type        = "string"
  description = "Instance type for Services cluster Redis cache"
  default     = "cache.m4.large"
}

variable "elasticache_instance_type_facebox" {
  type        = "string"
  description = "Instance type for Facebox Redis cache"
  default     = "cache.m4.large"
}

variable "elasticsearch_volume_size" {
  type        = "string"
  description = "The size of the disk, in GB"
  default     = "10"
}

variable "elasticsearch_instance_type" {
  type        = "string"
  description = "Instance type of data nodes in the cluster"
  default     = "m4.large.elasticsearch"
}

variable "elasticsearch_dedicated_master_type" {
  type        = "string"
  description = "Instance type of the dedicated master nodes in the cluster"
  default     = "m4.large.elasticsearch"
}

variable "elasticsearch_dedicated_master_count" {
  type        = "string"
  description = "Number of dedicated master nodes in the cluster"
  default     = "3"
}

variable "elasticsearch_instance_count" {
  type        = "string"
  description = "Number of data instances in the cluster. Because zone awareness is enabled, this should always be an even number"
  default     = "2"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

variable "notifications_from_addr" {
  type        = "string"
  description = "The email address to use as the From address on email notifications. This must be an SES verified email address"
}

variable "rollbar_token" {
  type        = "string"
  description = "A token used for accessing the Rollbar API for the purposes of reporting errors. Optional"
  default     = ""
}

variable "encrypted_config_blob" {
  type        = "string"
  description = "base64 encoded string of encrypted data from the gmcrypt utility. Contact GrayMeta for more information"
  default     = ""
}

variable "services_iam_role_name" {
  type        = "string"
  description = "The name of the IAM role that will be applied to services roles. Must be created by the servicesiam module"
}

variable "harvest_complete_stow_fields" {
  type        = "string"
  description = "Optional. A comma-delimited list of strings that correspond to the names of Stow metadata keys or Stow tag keys to include in harvest complete notification messages. Case insensitive."
  default     = ""
}

variable "sqs_s3notifications_arn" {
  type        = "string"
  description = "Optional. The ARN of the queue that will be subscribed to s3 ObjectCreated notifications."
  default     = ""
}

variable "sqs_s3notifications" {
  type        = "string"
  description = "Optional. The queue url of the s3 notifications queue . Optional."
  default     = ""
}

variable "s3subscriber_priority" {
  type        = "string"
  description = "Optional. The priority to assign jobs registered by s3 notifications. Valid values 1-10 (1=highest priority). Set to 0 for default priority."
  default     = "0"
}

variable "ecs_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on ECS instances. (Not Recommened)"
  default     = ""
}

variable "services_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on Service instances. (Not Recommened)"
  default     = ""
}

variable "log_retention" {
  type        = "string"
  description = "Optional. The log retention for cloudwatch logs.  Default 7 days"
  default     = "7"
}

# per-region ECS AMI can be found at  http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
# Limiting factor for region support is EFS: http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticfilesystem-region
variable ecs_amis {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "us-east-1"      = "ami-0e835215796dcb94e"
    "us-east-2"      = "ami-0cac9dc1cab846291"
    "us-west-2"      = "ami-0e17e79667b024a16"
    "ap-southeast-2" = "ami-01d7b721f28944496"
    "eu-west-1"      = "ami-0053d0f6921d13d17"
  }
}

variable services_amis {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "us-east-1"      = "ami-0a8d3d930090c9996"
    "us-east-2"      = "ami-05ba21e4653b048e1"
    "us-west-2"      = "ami-0cf7e048792f9181b"
    "ap-southeast-2" = "ami-0d9303883fbd22291"
    "eu-west-1"      = "ami-07c82f0325d0f4a22"
  }
}

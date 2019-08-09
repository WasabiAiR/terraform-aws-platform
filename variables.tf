variable "account_lockout_attempts" {
  type        = "string"
  description = "The number of failed login attempts that will trigger an account lockout. Default: 5"
  default     = "5"
}

variable "account_lockout_interval" {
  type        = "string"
  description = "The amount of time an account is locked out after exceeding the threshold for number of failed logins. Default: 10m.  Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = "10m"
}

variable "account_lockout_period" {
  type        = "string"
  description = "The window of time for failed login attempts to trigger an account lockout. Default: 10m.  Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = "10m"
}

variable "az1_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from az1 is NAT'ed through to allow access to the APIs"
}

variable "az2_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from az2 is NAT'ed through to allow access to the APIs"
}

variable "box_com_client_id" {
  type        = "string"
  description = "Box.com client ID"
  default     = ""
}

variable "box_com_secret_key" {
  type        = "string"
  description = "Box.com application secret key"
  default     = ""
}

variable "bcrypt_cost" {
  type        = "string"
  description = "bcrypt cost factor for hashing passwords"
  default     = "14"
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

variable "customer" {
  type        = "string"
  description = "A human-readable string that identifies your company. Should be alphanumeric + underscores only. eg. If your company is 'XYZ Widgets', you might set it to 'xyzwidgets' or 'xyz_widgets'"
}

variable "db_allocated_storage" {
  type        = "string"
  description = "The size of the storage to allocate for the RDS database, in GB"
  default     = "100"
}

variable "db_backup_retention" {
  type        = "string"
  description = "RDS backup retention"
  default     = "7"
}

variable "db_backup_window" {
  type        = "string"
  description = "RDS Backup window"
  default     = "03:00-04:00"
}

variable "db_instance_size" {
  type        = "string"
  description = "The size of the instance to use for the RDS database instance"
  default     = "db.t2.small"
}

variable "db_kms_key_id" {
  type        = "string"
  description = "(Optional) The ARN for the KMS encryption key.  If not specified and db_storage_encrypted is true, it will generate a kms key"
  default     = ""
}

variable "db_multi_az" {
  type        = "string"
  description = "Multizone setting in RDS.  Default is true"
  default     = true
}

variable "db_password" {
  type        = "string"
  description = "password for postgresql database"
  default     = ""
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

variable "db_username" {
  type        = "string"
  description = "username for postgresql database"
}

variable "dns_name" {
  type        = "string"
  description = "The DNS hostname that will be used to access the plaform (ex. graymeta.example.com)"
}

variable "dropbox_app_key" {
  type        = "string"
  description = "Dropbox application key"
  default     = ""
}

variable "dropbox_app_secret" {
  type        = "string"
  description = "Dropbox application secret"
  default     = ""
}

variable "ecs_cpu_reservation" {
  type        = "string"
  description = "Not recommened to change unless you talk to GrayMeta support.  Default: 1024"
  default     = "1024"
}

variable "ecs_instance_type" {
  type        = "string"
  description = "The Instance Type to use for ECS nodes"
  default     = "c4.large"
}

variable "ecs_max_cluster_size" {
  type        = "string"
  description = "The maxiumum number of nodes in the ECS cluster"
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

variable "ecs_min_cluster_size" {
  type        = "string"
  description = "The minimum number of nodes in the ECS cluster"
  default     = "1"
}

variable "ecs_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the ECS cluster into"
}

variable "ecs_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the ECS cluster into"
}

variable "ecs_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on ECS instances. (Not Recommened)"
  default     = ""
}

variable "ecs_volume_size" {
  type        = "string"
  description = "The size of the EBS volumes to mount to ECS nodes. This is workload dependent. Contact GrayMeta for a recommendation"
}

variable "elasticache_instance_type_services" {
  type        = "string"
  description = "Instance type for Services cluster Redis cache"
  default     = "cache.m4.large"
}

variable "elasticsearch_dedicated_master_count" {
  type        = "string"
  description = "Number of dedicated master nodes in the cluster"
  default     = "3"
}

variable "elasticsearch_dedicated_master_type" {
  type        = "string"
  description = "Instance type of the dedicated master nodes in the cluster"
  default     = "m4.large.elasticsearch"
}

variable "elasticsearch_instance_count" {
  type        = "string"
  description = "Number of data instances in the cluster. Because zone awareness is enabled, this should always be an even number"
  default     = "2"
}

variable "elasticsearch_instance_type" {
  type        = "string"
  description = "Instance type of data nodes in the cluster"
  default     = "m4.large.elasticsearch"
}

variable "elasticsearch_subnet_id_1" {
  type        = "string"
  description = "The first elasticsearch subnet ID to use. Needs to be in a different AZ than elasticsearch_subnet_id_2"
}

variable "elasticsearch_subnet_id_2" {
  type        = "string"
  description = "The second elasticsearch subnet ID to use. Needs to be in a different AZ than elasticsearch_subnet_id_1"
}

variable "elasticsearch_volume_size" {
  type        = "string"
  description = "The size of the disk, in GB"
  default     = "10"
}

variable "encrypted_config_blob" {
  type        = "string"
  description = "base64 encoded string of encrypted data from the gmcrypt utility. Contact GrayMeta for more information"
  default     = ""
}

variable "encryption_key" {
  type        = "string"
  description = "32 Character string used to encrypt data prior to storage in the database"
  default     = ""
}

variable "faces_endpoint" {
  type        = "string"
  description = "Faces endpoint from the faces module"
  default     = ""
}

variable "file_storage_s3_bucket_arn" {
  type        = "string"
  description = "The ARN of the s3 bucket to store thumbnails, video previews, and metadata files"
}

variable "gm_celeb_detection_enabled" {
  type        = "string"
  description = "Whether or not celeb detection is enabled"
  default     = "false"
}

variable "gm_celeb_detection_interval" {
  type        = "string"
  description = "Celeb detection interval. Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = "5m"
}

variable "gm_celeb_detection_min_confidence" {
  type        = "string"
  description = "Celeb detection min confidence. Recommended for gmceleb is 0.5, awsrekog is 90  Default: 0.5"
  default     = "0.5"
}

variable "gm_celeb_detection_provider" {
  type        = "string"
  description = "Celeb detection provider. Valid values are gmceleb, awsrekog.  Default: gmceleb"
  default     = "gmceleb"
}

variable "gm_es_bulk_size" {
  type        = "string"
  description = "The max size for bulk http requests.  Not recommened to change unless you talk to GrayMeta support.  Default: 100000000"
  default     = "20000000"
}

variable "gm_es_bulk_workers" {
  type        = "string"
  description = "The number of ES bulk workers.  Not recommened to change unless you talk to GrayMeta support.  Default: 2"
  default     = "2"
}

variable "gm_jwt_expiration_time" {
  type        = "string"
  description = "The amount of time a session token is valid for. Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = "168h"
}

variable "gm_license_key" {
  type        = "string"
  description = "The GrayMeta Platform license key. Contact support@graymeta.com if you have not been provided a license key"
}

variable "gm_threshold_to_harvest" {
  type        = "string"
  description = "The minimum amount of time between two harvests of the same container. Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = ""
}

variable "google_maps_key" {
  type        = "string"
  description = "A Google maps key"
  default     = ""
}

variable "harvest_complete_stow_fields" {
  type        = "string"
  description = "Optional. A comma-delimited list of strings that correspond to the names of Stow metadata keys or Stow tag keys to include in harvest complete notification messages. Case insensitive."
  default     = ""
}

variable "harvest_polling_time" {
  type        = "string"
  description = "Live Harvest Polling time.  Default: 6h. Valid values must be parseable as a Golang time.Duration (see https://godoc.org/time#ParseDuration)"
  default     = "6h"
}

variable "jwt_key" {
  type        = "string"
  description = "A 32 character string used to encrypt JWT web tokens"
  default     = ""
}

variable "key_name" {
  type        = "string"
  description = "The name of the EC2 keypair to deploy to instances"
}

variable "log_retention" {
  type        = "string"
  description = "Optional. The log retention for cloudwatch logs.  Default 7 days"
  default     = "7"
}

variable "notifications_from_addr" {
  type        = "string"
  description = "The email address to use as the From address on email notifications. This must be an SES verified email address"
}

variable "notifications_region" {
  type        = "string"
  description = "The region that SES was setup in.  Default will be the region of the platform"
  default     = ""
}

variable "mlservices_endpoint" {
  type        = "string"
  description = "The dns_name of the ML Services loadbalancer."
  default     = ""
}

variable "oauthconnect_encryption_key" {
  type        = "string"
  description = "32 Character string used in oauth authentication.  Set this to blank if specified in the crypt blob."
}

variable "password_min_length" {
  type        = "string"
  description = "Minimum password length. Default: 8"
  default     = "8"
}

variable "platform_access_cidrs" {
  type        = "string"
  description = "A comma delimited list of CIDRs from which to allow access to the site."
}

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "proxy_endpoint" {
  type        = "string"
  description = "The Proxy Load Balancer created by the network module"
}

variable "public_subnet_id_1" {
  type        = "string"
  description = "The first public subnet ID to use. Needs to be in a different AZ than public_subnet_id_2"
}

variable "public_subnet_id_2" {
  type        = "string"
  description = "The second public subnet ID to use. Needs to be in a different AZ than public_subnet_id_1"
}

variable "rds_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_2"
}

variable "rds_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_1"
}

variable "region" {
  type        = "string"
  description = "The region to deploy into"
}

variable "rollbar_token" {
  type        = "string"
  description = "A token used for accessing the Rollbar API for the purposes of reporting errors. Optional"
  default     = ""
}

variable "s3subscriber_priority" {
  type        = "string"
  description = "Optional. The priority to assign jobs registered by s3 notifications. Valid values 1-10 (1=highest priority). Set to 0 for default priority."
  default     = "0"
}

variable "segment_write_key" {
  type        = "string"
  description = "Segment.com Analytics Write Key. Set to an empty string to disable analytics."
  default     = ""
}

variable "services_iam_role_name" {
  type        = "string"
  description = "The name of the IAM role that will be applied to services roles. Must be created by the servicesiam module"
}

variable "services_instance_type" {
  type        = "string"
  description = "The Instance Type to use for Services nodes"
  default     = "m4.large"
}

variable "services_scale_down_threshold_cpu" {
  type        = "string"
  description = "The CPU threshold the services cluster needs to reach before it begins to scale back in"
  default     = "50"
}

variable "services_scale_up_threshold_cpu" {
  type        = "string"
  description = "The CPU threshold the services cluster needs to reach before it begins to scale out"
  default     = "70"
}

variable "services_max_cluster_size" {
  type        = "string"
  description = "The maximum number of nodes in the Services cluster"
}

variable "services_min_cluster_size" {
  type        = "string"
  description = "The minimum number of nodes in the Services cluster"
  default     = "2"
}

variable "services_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the services cluster into. Needs to be in a different AZ than services_subnet_id_2"
}

variable "services_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the services cluster into. Needs to be in a different AZ than services_subnet_id_1"
}

variable "services_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on Service instances. (Not Recommened)"
  default     = ""
}

variable "sqs_s3notifications" {
  type        = "string"
  description = "Optional. The queue url of the s3 notifications queue . Optional."
  default     = ""
}

variable "sqs_s3notifications_arn" {
  type        = "string"
  description = "Optional. The ARN of the queue that will be subscribed to s3 ObjectCreated notifications."
  default     = ""
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

variable "ssl_certificate_arn" {
  type        = "string"
  description = "The ARN of the SSL certificate to use to secure the endpoints. Must be a valid CA issued certificate (no self-signed certs)"
}

variable "usage_s3_bucket_arn" {
  type        = "string"
  description = "The ARN of the s3 bucket to store usage reports"
}

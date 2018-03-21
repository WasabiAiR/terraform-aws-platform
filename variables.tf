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

variable "ecs_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from the ECS cluster is NAT'ed through to allow access to the APIs"
}

variable "services_nat_ip" {
  type        = "string"
  description = "The public IP all traffic from the Services cluster is NAT'ed through to allow access to the APIs"
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

variable "google_maps_key" {
  type        = "string"
  description = "A Google maps key"
}

variable "jwt_key" {
  type        = "string"
  description = "A 32 character string used to encrypt JWT web tokens"
  default     = ""
}

variable "box_client_id" {
  type        = "string"
  description = "Box Client ID key. See box.com"
  default     = ""
}

variable "box_client_secret" {
  type        = "string"
  description = "Box client secret. See box.com"
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

# per-region ECS AMI can be found at  http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
# Limiting factor for region support is EFS: http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticfilesystem-region
variable ecs_amis {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "us-east-1"      = "ami-d6d205ab"
    "us-east-2"      = "ami-9ee2fd72"
    "us-west-2"      = "ami-b93ea2c1"
    "ap-southeast-2" = "ami-06dd1064"
    "eu-west-1"      = "ami-32de8a4b"
  }
}

variable services_amis {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "us-east-1"      = "ami-3ad40347"
    "us-east-2"      = "ami-4c417029"
    "us-west-2"      = "ami-053aa67d"
    "ap-southeast-2" = "ami-a9c30ecb"
    "eu-west-1"      = "ami-2edf8b57"
  }
}

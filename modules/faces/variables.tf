variable "faces_instance_type" {
  type        = "string"
  description = "instance type for servers"
}

variable "faces_max_cluster_size" {
  type        = "string"
  description = "The max number of faces server nodes to spin up"
}

variable "faces_min_cluster_size" {
  type        = "string"
  description = "The max number of faces server nodes to spin up"
}

variable "faces_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the faces cluster into. Needs to be in a different AZ than faces_subnet_id_2"
}

variable "faces_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the faces cluster into. Needs to be in a different AZ than faces_subnet_id_1"
}

variable "faces_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on faces instances. (Not Recommened)"
  default     = ""
}

variable "faces_volume_size" {
  type        = "string"
  description = "The OS disk size for Faces Server"
  default     = "50"
}

variable "key_name" {
  type        = "string"
  description = "The name of the SSH key to use"
}

variable "log_retention" {
  type        = "string"
  description = "Optional. The log retention for cloudwatch logs.  Default 7 days"
  default     = "7"
}

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "proxy_endpoint" {
  type        = "string"
  description = "The Proxy Load Balancer created by the network module"
}

variable "rds_allocated_storage" {
  type        = "string"
  description = "Number of GB to allocate for RDS faces instance"
  default     = "100"
}

variable "rds_backup_retention" {
  type        = "string"
  description = "RDS backup retention"
  default     = "7"
}

variable "rds_backup_window" {
  type        = "string"
  description = "RDS Backup window"
  default     = "03:00-04:00"
}

variable "rds_db_instance_size" {
  type        = "string"
  description = "The size of the instance to use for the RDS database instance"
  default     = "db.t2.small"
}

variable "rds_db_password" {
  type        = "string"
  description = "password for postgresql database"
}

variable "rds_db_username" {
  type        = "string"
  description = "username for postgresql database"
}

variable "rds_multi_az" {
  type        = "string"
  description = "Multizone setting in RDS.  Default is true"
  default     = true
}

variable "rds_snapshot" {
  type        = "string"
  description = "(Optional) Specify a snapshot to use on db create.  For initial install this should be empty string.  After the initial create it is recommended to set this to final."
  default     = ""
}

variable "rds_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_2"
}

variable "rds_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_1"
}

variable "services_ecs_cidrs" {
  type        = "list"
  description = "List of services and ecs subnet ids"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

# AMI
variable "faces_amis" {
  type        = "map"
  description = "map of region to ami for faces nodes"

  default = {
    "ap-southeast-2" = "ami-061e9d1cd348309ab"
    "eu-west-1"      = "ami-0df669b86273e1ad0"
    "us-east-1"      = "ami-00a99729c2d3778da"
    "us-east-2"      = "ami-08a2aea98d05d71cf"
    "us-west-2"      = "ami-05c6cc2d3bafcce48"
  }
}

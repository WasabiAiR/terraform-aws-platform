variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "faces_instance_type" {
  type        = "string"
  description = "instance type for servers"
  default     = "m5.2xlarge"
}

variable "faces_max_cluster_size" {
  type        = "string"
  description = "The max number of faces server nodes to spin up"
  default     = "2"
}

variable "faces_min_cluster_size" {
  type        = "string"
  description = "The max number of faces server nodes to spin up"
  default     = "2"
}

variable "faces_volume_size" {
  type        = "string"
  description = "The OS disk size for Faces Server"
  default     = "50"
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

variable "faces_iam_role_name" {
  type        = "string"
  description = "The name of the IAM role that will be applied to faces roles. Must be created by the facesiam module"
}

# RDS
variable "rds_allocated_storage" {
  type    = "string"
  default = "50"
}

variable "rds_db_instance_size" {
  type    = "string"
  default = "db.t2.small"
}

variable "rds_db_username" {
  type    = "string"
  default = "gmuser"
}

variable "rds_db_password" {
  type    = "string"
  default = "gmchangeme"
}

variable "rds_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_2"
}

variable "rds_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the RDS database into. Needs to be in a different AZ than rds_subnet_id_1"
}

variable "key_name" {
  type        = "string"
  description = "The name of the SSH key to use"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

variable "services_ecs_cidrs" {
  type        = "list"
  description = "List of services and ecs subnet ids"
}

variable "log_retention" {
  type        = "string"
  description = "Optional. The log retention for cloudwatch logs.  Default 7 days"
  default     = "7"
}

variable "faces_amis" {
  type        = "map"
  description = "map of region to ami for faces nodes"

  default = {
    "us-east-1"      = ""
    "us-east-2"      = ""
    "us-west-2"      = "ami-0b4943b7d0bd643b3"
    "ap-southeast-2" = ""
    "eu-west-1"      = ""
  }
}

variable "instance_type" {
  type        = "string"
  description = "ec2 instance type"
}

variable "max_cluster_size" {
  type        = "string"
  description = "The max number of ec2 instances to spin up"
}

variable "min_cluster_size" {
  type        = "string"
  description = "The max number of ec2 instances to spin up"
}

variable "ml_loadbalancer_output" {
  type        = "map"
  description = "The output from the ml_network module"
}

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "rds_asg_target_cpu" {
  type        = "string"
  description = "RDS ASG target CPU"
  default     = "80"
}

variable "rds_asg_scalein_cooldown" {
  type        = "string"
  description = "RDS ASG Scale In cooldown"
  default     = "300"
}

variable "rds_asg_scaleout_cooldown" {
  type        = "string"
  description = "RDS ASG Scale Out cooldown"
  default     = "300"
}

variable "rds_asg_max_capacity" {
  type        = "string"
  description = "RDS max number of read nodes"
  default     = "15"
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
  default     = "db.r4.2xlarge"
}

variable "rds_db_password" {
  type        = "string"
  description = "password for postgresql database"
}

variable "rds_db_username" {
  type        = "string"
  description = "username for postgresql database"
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

variable "rds_version" {
  type        = "string"
  description = "The Aurora postgres version.  Default 10.11"
  default     = "10.11"
}

variable "services_ecs_cidrs" {
  type        = "list"
  description = "The list of cidrs to allow connection to cluster"
}

variable "user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on cluster instances. (Not Recommened)"
  default     = ""
}

variable "volume_size" {
  type        = "string"
  description = "The OS disk size for credits Server"
  default     = "50"
}

data "aws_region" "current" {}

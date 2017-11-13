variable "region" {
    type        = "string"
    description = "The region to deploy into"
}

variable "platform_instance_id" {
    type        = "string"
    description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "volume_size" {
    type        = "string"
    description = "The size of the disk, in GB"
    default     = "10"
}

variable "instance_type" {
    type        = "string"
    description = "Instance type of data nodes in the cluster"
    default     = "m4.large.elasticsearch"
}

variable "dedicated_master_type" {
    type        = "string"
    description = "Instance type of the dedicated master nodes in the cluster"
    default     = "m4.large.elasticsearch"
}

variable "dedicated_master_count" {
    type        = "string"
    description = "Number of dedicated master nodes in the cluster"
    default     = "3"
}

variable "instance_count" {
    type = "string"
    description = "Number of instances in the cluster. Because zone awareness is enabled, this should always be an even number"
    default = "2"
}

variable "subnet_id_1" {
    type        = "string"
    description = "The id of the first subnet to expose ES endpoints into. Needs to have at least instance_count / 2 * 3 addresses available. Should be in a different AZ than subnet_id_2"
}

variable "subnet_id_2" {
    type        = "string"
    description = "The id of the second subnet to expose ES endpoints into. Needs to have at least instance_count / 2 * 3 addresses available. Should be in a different AZ than subnet_id_1"
}

variable "security_group_ids" {
    type        = "string"
    description = "Comma delimited string of security group ids to allow access to the ES domain."
}

data "aws_caller_identity" "current" {}

data "aws_subnet" "subnet_1" {
      id = "${var.subnet_id_1}"
}

data "aws_subnet" "subnet_2" {
      id = "${var.subnet_id_2}"
}

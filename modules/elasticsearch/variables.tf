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

variable "source_ip" {
    type        = "string"
    description = "The source IP to allow access to the ES cluster. Should be the EIP of the NAT for the services subnet"
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
    description = "Number of instances in the cluster"
    default = "2"
}

data "aws_caller_identity" "current" {}

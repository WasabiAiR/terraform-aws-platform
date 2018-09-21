variable "az1" {
  type        = "string"
  description = "Availability zone 1"
}

variable "az2" {
  type        = "string"
  description = "Availability zone 2"
}

variable "cidr_subnet_public_1" {
  type        = "string"
  description = "The CIDR block to use for the public 1 subnet"
  default     = "10.0.0.0/24"
}

variable "cidr_subnet_public_2" {
  type        = "string"
  description = "The CIDR block to use for the public 2 subnet"
  default     = "10.0.1.0/24"
}

variable "cidr_subnet_rds_1" {
  type        = "string"
  description = "The CIDR block to use for the rds 1 subnet"
  default     = "10.0.2.0/24"
}

variable "cidr_subnet_rds_2" {
  type        = "string"
  description = "The CIDR block to use for the rds 2 subnet"
  default     = "10.0.3.0/24"
}

variable "cidr_subnet_services_1" {
  type        = "string"
  description = "The CIDR block to use for the services 1 subnet"
  default     = "10.0.4.0/24"
}

variable "cidr_subnet_services_2" {
  type        = "string"
  description = "The CIDR block to use for the services 2 subnet"
  default     = "10.0.5.0/24"
}

variable "cidr_subnet_ecs_1" {
  type        = "string"
  description = "The CIDR block to use for the ecs subnet"
  default     = "10.0.8.0/21"
}

variable "cidr_subnet_ecs_2" {
  type        = "string"
  description = "The CIDR block to use for the ecs subnet"
  default     = "10.0.24.0/21"
}

variable "cidr_subnet_elasticsearch_1" {
  type        = "string"
  description = "The CIDR block to use for the elasticsearch 1 subnet"
  default     = "10.0.16.0/24"
}

variable "cidr_subnet_elasticsearch_2" {
  type        = "string"
  description = "The CIDR block to use for the elasticsearch 2 subnet"
  default     = "10.0.17.0/24"
}

variable "cidr_subnet_faces_1" {
  type        = "string"
  description = "The CIDR block to use for the faces 1 subnet"
  default     = "10.0.18.0/24"
}

variable "cidr_subnet_faces_2" {
  type        = "string"
  description = "The CIDR block to use for the faces 2 subnet"
  default     = "10.0.19.0/24"
}

variable "cidr_subnet_proxy_1" {
  type        = "string"
  description = "The CIDR block to use for the proxy 1 subnet"
  default     = "10.0.20.0/24"
}

variable "cidr_subnet_proxy_2" {
  type        = "string"
  description = "The CIDR block to use for the proxy 2 subnet"
  default     = "10.0.21.0/24"
}

variable "cidr_vpc" {
  type        = "string"
  description = "The CIDR block to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "dns_name" {
  type        = "string"
  description = "The DNS hostname that will be used to access the plaform (ex. graymeta.example.com)"
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

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "proxy_instance_type" {
  type        = "string"
  description = "The instance type to use for proxy nodes"
  default     = "m3.large"
}

variable "proxy_max_cluster_size" {
  type        = "string"
  description = "The maximum number of nodes in the Proxy cluster"
}

variable "proxy_min_cluster_size" {
  type        = "string"
  description = "The minimum number of nodes in the Proxy cluster"
}

variable "proxy_scale_down_thres" {
  type        = "string"
  description = "Threshold in Bytes when to scale down the proxy cluster"
}
variable "proxy_scale_up_thres" {
  type        = "string"
  description = "Threshold in Bytes when to scale up the proxy cluster"
}

variable "proxy_user_init" {
  type        = "string"
  description = "Custom cloud-init that is rendered to be used on proxy instances. (Not Recommened)"
  default     = ""
}

variable "proxy_volume_size" {
  type        = "string"
  description = "Size of the root volume"
  default     = "30"
}

variable "region" {
  type        = "string"
  description = "The region to deploy into"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

# AMI
variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "eu-west-1"      = "ami-0b36b80302f4b80d0"
    "us-east-1"      = "ami-0aa5316c40520da2c"
    "us-east-2"      = "ami-0bc19d0e0cad89ade"
    "us-west-2"      = "ami-05cf604a220871d76"
    "ap-southeast-2" = "ami-0942a64a2acc96ee4"
  }
}

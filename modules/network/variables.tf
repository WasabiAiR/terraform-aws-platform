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

variable "enforce_proxy" {
  type        = "string"
  description = "Only needed if using Watson extractor.  Please talk to Graymeta Support before changing"
  default     = true
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

variable "proxy_scale_down_evaluation_periods" {
  type        = "string"
  description = "The scale down evaluation periods.  Default 4"
  default     = "4"
}

variable "proxy_scale_down_period" {
  type        = "string"
  description = "The scale down period.  Default 300"
  default     = "300"
}

variable "proxy_scale_down_thres" {
  type        = "string"
  description = "Threshold in Bytes when to scale down the proxy cluster"
}

variable "proxy_scale_up_evaluation_periods" {
  type        = "string"
  description = "The scale up evaluation periods.  Default 2"
  default     = "2"
}

variable "proxy_scale_up_period" {
  type        = "string"
  description = "The scale up period.  Default 120"
  default     = "120"
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
    "ap-southeast-2" = "ami-081c3bca5bb0fb280"
    "eu-west-1"      = "ami-09d0344514bef6484"
    "us-east-1"      = "ami-0b4fa399234c5ab0b"
    "us-east-2"      = "ami-07586ac64d109340a"
    "us-west-2"      = "ami-017379caf2e25ac14"
  }
}

variable "safelist" {
  type        = "list"
  description = "List of dstdomain to add to the proxy server.  Please talk to Graymeta Support before changing"

  default = [
    ".amazonaws.com",
    ".box.com",
    ".boxcloud.com",
    ".cognitive.microsoft.com",
    ".core.windows.net",
    ".darksky.net",
    ".dropboxapi.com",
    ".forecast.io",
    ".geonames.org",
    ".googleapis.com",
    ".graymeta.com",
    ".kairos.com",
    ".logograb.com",
    ".picpurify.com",
    ".platform.bing.com",
    ".speechmatics.com",
    ".valossa.com",
    ".voicebase.com",
    ".watsonplatform.net",
  ]
}

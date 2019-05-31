variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-022aa7137a03effc8"
    "eu-west-1"      = "ami-003793db1af35ac94"
    "us-east-1"      = "ami-0155a1f1e701e82a4"
    "us-east-2"      = "ami-051afe7c9392082d3"
    "us-west-2"      = "ami-071e41a9e3a5a8379"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-04c19799568fe9fc4"
    "eu-west-1"      = "ami-0628f034bf9e35a9b"
    "us-east-1"      = "ami-0d30331095d3c8943"
    "us-east-2"      = "ami-0bca8120c5600b937"
    "us-west-2"      = "ami-08c59f70ee2f34f52"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0b733af4e7f802df7"
    "eu-west-1"      = "ami-05c8d6b77950a6e66"
    "us-east-1"      = "ami-08b89635f804c2ea5"
    "us-east-2"      = "ami-0a8303c333d432717"
    "us-west-2"      = "ami-0fcf52538276319b6"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0765e6baad59c17dc"
    "eu-west-1"      = "ami-0f684aa51fd8ac084"
    "us-east-1"      = "ami-0223d1a3a27dd9a37"
    "us-east-2"      = "ami-038d8554036b911a8"
    "us-west-2"      = "ami-08302aa6fc335d9d0"
  }
}

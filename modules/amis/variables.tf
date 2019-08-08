variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-04d33df9d8dfcf25f"
    "eu-west-1"      = "ami-0db1b03e2e354a8ee"
    "us-east-1"      = "ami-0a9e321f2dd5c9e6e"
    "us-east-2"      = "ami-08ab3bc1aed059589"
    "us-west-2"      = "ami-08e6165ed2ecd6d79"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-054b15ac26dfcf040"
    "eu-west-1"      = "ami-086d2a87e9e4a66d4"
    "us-east-1"      = "ami-0eabd02df29333a1a"
    "us-east-2"      = "ami-0bc02493fb2d9dfde"
    "us-west-2"      = "ami-0ebddcf03ef7a47e0"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0664f90b14f1664bf"
    "eu-west-1"      = "ami-00acf0587573c066b"
    "us-east-1"      = "ami-0b2abd0cfede01a0c"
    "us-east-2"      = "ami-06a15831fe3a03347"
    "us-west-2"      = "ami-06cf998a2dbe3c143"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-09cb19eef29192b77"
    "eu-west-1"      = "ami-04c22511701df234b"
    "us-east-1"      = "ami-02554b35134fbad5a"
    "us-east-2"      = "ami-014a898727da2fffd"
    "us-west-2"      = "ami-0d7303063104de943"
  }
}

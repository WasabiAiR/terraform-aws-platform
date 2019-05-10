variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0914df0c5334e3ddd"
    "eu-west-1"      = "ami-01070725a5f5225f9"
    "us-east-1"      = "ami-04fb9fce965271e4b"
    "us-east-2"      = "ami-0520c9e6229c31ff7"
    "us-west-2"      = "ami-09d381462ae48a138"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0e51cc1966172479d"
    "eu-west-1"      = "ami-084d0985f89e6862c"
    "us-east-1"      = "ami-071ea359d44d8f468"
    "us-east-2"      = "ami-0944e09ba7cddbc98"
    "us-west-2"      = "ami-0ff3c229e32f868c9"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-089c3506ad7ba02ae"
    "eu-west-1"      = "ami-07d8d349fbffabefa"
    "us-east-1"      = "ami-0736448aebe0b6599"
    "us-east-2"      = "ami-03885972d7cc23fd9"
    "us-west-2"      = "ami-014a27293ebac04d2"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0c03846339dec6681"
    "eu-west-1"      = "ami-06aa4f00ea2a2aaef"
    "us-east-1"      = "ami-060da7943959da0ac"
    "us-east-2"      = "ami-0bdc17e4e97e06276"
    "us-west-2"      = "ami-03261f22de8d2c18e"
  }
}

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
    "ap-southeast-2" = "ami-08ecd49f86630aa20"
    "eu-west-1"      = "ami-094b185c45d7bb962"
    "us-east-1"      = "ami-0737b3d77d84a3278"
    "us-east-2"      = "ami-0ba4340bf72620184"
    "us-west-2"      = "ami-07e6565fa0ddc84c4"
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

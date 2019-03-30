variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-01925c67ec1a777fc"
    "eu-west-1"      = "ami-00ce992987aeb6be2"
    "us-east-1"      = "ami-0fe832e8d133ee5a9"
    "us-east-2"      = "ami-0b77204461ff0428a"
    "us-west-2"      = "ami-0194d85f1005a347b"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-04099d517756eb059"
    "eu-west-1"      = "ami-01af035c83e5d6ca1"
    "us-east-1"      = "ami-0c468ee26e5042d42"
    "us-east-2"      = "ami-06ef48ef16cc256a1"
    "us-west-2"      = "ami-0294365075591de78"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-019b5c732af3682c4"
    "eu-west-1"      = "ami-00ad67ff94c02d8ff"
    "us-east-1"      = "ami-061e8455c8f536a13"
    "us-east-2"      = "ami-0bc4bd813ad137021"
    "us-west-2"      = "ami-0e9dde507eddd22b3"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0805f34e7c3ccf498"
    "eu-west-1"      = "ami-00343f07d4e320424"
    "us-east-1"      = "ami-0603f4d544baaa7be"
    "us-east-2"      = "ami-0a6ba06ac08c2dea7"
    "us-west-2"      = "ami-09b4917ba5a5ac3eb"
  }
}

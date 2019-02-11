variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0c200ee6ed0c39907"
    "eu-west-1"      = "ami-03d443b9700eb0c5c"
    "us-east-1"      = "ami-03279f49db725b2aa"
    "us-east-2"      = "ami-0795f95e0574b17c5"
    "us-west-2"      = "ami-0a231fb8ef2df0d92"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0612899aaab2a9f45"
    "eu-west-1"      = "ami-0d519ea25a5d2914d"
    "us-east-1"      = "ami-0bdf31d1f725256ed"
    "us-east-2"      = "ami-0b1dfd6b0761f4505"
    "us-west-2"      = "ami-0534453055684be0d"
  }
}

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

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-080dfeddac76f3ad7"
    "eu-west-1"      = "ami-0123f9b2f35c0ee5a"
    "us-east-1"      = "ami-0933c032b60d16c39"
    "us-east-2"      = "ami-0dc50bafb082d64f0"
    "us-west-2"      = "ami-0f9c9d94b62145028"
  }
}

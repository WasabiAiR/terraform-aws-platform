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
    "ap-southeast-2" = "ami-05cd1a61d495c681a"
    "eu-west-1"      = "ami-03f597608ec9fd7cf"
    "us-east-1"      = "ami-0d42ae192ff6ed15a"
    "us-east-2"      = "ami-00d4863607b509d9d"
    "us-west-2"      = "ami-067fdc1cfd4630b85"
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

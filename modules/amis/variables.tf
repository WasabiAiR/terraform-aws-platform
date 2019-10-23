variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-03274069cd28f502d"
    "eu-west-1"      = "ami-01598c4664b32fff3"
    "us-east-1"      = "ami-0787addc5084fb71e"
    "us-east-2"      = "ami-0962ff5a695839102"
    "us-west-2"      = "ami-0b04b65f594d85b88"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0b612ebf71e50aba0"
    "eu-west-1"      = "ami-0a5fdb1fccf7e68d9"
    "us-east-1"      = "ami-0c9a210fd5c76ecd4"
    "us-east-2"      = "ami-04658833954a690e4"
    "us-west-2"      = "ami-037d35c7968b3177d"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-098359b323d053492"
    "eu-west-1"      = "ami-09359966607cdfc51"
    "us-east-1"      = "ami-0e68fc624f8f6af42"
    "us-east-2"      = "ami-0575481f9f3ae875e"
    "us-west-2"      = "ami-0b774fc38ca1d1c93"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0d73104b33158b0b5"
    "eu-west-1"      = "ami-03971e958e912d199"
    "us-east-1"      = "ami-070a0489b4d4071eb"
    "us-east-2"      = "ami-0f4da8e9f6bad1443"
    "us-west-2"      = "ami-030f0642359b8849c"
  }
}

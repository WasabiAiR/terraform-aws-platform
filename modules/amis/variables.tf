variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-09c115139218dc445"
    "eu-west-1"      = "ami-01ab70a414c6bc755"
    "us-east-1"      = "ami-0e1ba31891c43614c"
    "us-east-2"      = "ami-06dc921a7dc5b9d8f"
    "us-west-2"      = "ami-089742a237c386079"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-03627b31e24c1ed4d"
    "eu-west-1"      = "ami-0eb1bb29341d1c613"
    "us-east-1"      = "ami-0cef9e4b247eb1858"
    "us-east-2"      = "ami-0a1ef4eaf67d02ea3"
    "us-west-2"      = "ami-0af107b247c566af6"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0180a99bde7b28b1d"
    "eu-west-1"      = "ami-0ba48fd3511535542"
    "us-east-1"      = "ami-03ed6bb3e69c4931b"
    "us-east-2"      = "ami-08de396b709e585fa"
    "us-west-2"      = "ami-075bda1000ae046e7"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0678b96e7bf82dc06"
    "eu-west-1"      = "ami-08f4d4f7af9134d17"
    "us-east-1"      = "ami-037cf323b8615a5eb"
    "us-east-2"      = "ami-013d5d805a1847c1f"
    "us-west-2"      = "ami-0da0a5031f295689e"
  }
}

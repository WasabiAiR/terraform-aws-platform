variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0aa5f2e5ec607172f"
    "eu-west-1"      = "ami-0519597426b6c8505"
    "us-east-1"      = "ami-0d302d90ec5c6ee0d"
    "us-east-2"      = "ami-033c3e639530c0199"
    "us-west-2"      = "ami-07408cddd73f2caf8"
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
    "ap-southeast-2" = "ami-0ae421618a406fa2f"
    "eu-west-1"      = "ami-060476d94b62328f9"
    "us-east-1"      = "ami-079f5e01d753a8f48"
    "us-east-2"      = "ami-0934b01d168c7e93e"
    "us-west-2"      = "ami-005ae6a152f72af2f"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0a9bc8e5fa5a92d52"
    "eu-west-1"      = "ami-0d0b7030dc107d1f8"
    "us-east-1"      = "ami-0b7d5474ba5c2c383"
    "us-east-2"      = "ami-0bd9a64a324762068"
    "us-west-2"      = "ami-06fc14e50f7bb8607"
  }
}

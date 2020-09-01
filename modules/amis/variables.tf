variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0e140c28411a872e0"
    "eu-west-1"      = "ami-0b8a15f6dff963fd6"
    "us-east-1"      = "ami-09d39038658183ff4"
    "us-east-2"      = "ami-0d5e1f651b2faceb5"
    "us-west-2"      = "ami-049e5fd004044902f"
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
    "ap-southeast-2" = "ami-0a1691fd6f93515b1"
    "eu-west-1"      = "ami-000b01e3bac8199d0"
    "us-east-1"      = "ami-0dd59bb55f41d7969"
    "us-east-2"      = "ami-020c0040a6c23fd0d"
    "us-west-2"      = "ami-0d2eb0a4e73d884d7"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0cbfc91b74b839a01"
    "eu-west-1"      = "ami-060dd1e40d487b5ca"
    "us-east-1"      = "ami-047ad9dc718e9de46"
    "us-east-2"      = "ami-0c022ba78581f80ff"
    "us-west-2"      = "ami-0ad90bccbcc24a622"
  }
}

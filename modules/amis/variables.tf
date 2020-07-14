variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-062a2f54a363cc7db"
    "eu-west-1"      = "ami-022d4637fc6302992"
    "us-east-1"      = "ami-0fc2df40708043e12"
    "us-east-2"      = "ami-0f6883e6ab125a71e"
    "us-west-2"      = "ami-0cb274fbaaa648f78"
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
    "ap-southeast-2" = "ami-0c6034a8141936ace"
    "eu-west-1"      = "ami-0ed98d64f52a06184"
    "us-east-1"      = "ami-011bf41603d8b3307"
    "us-east-2"      = "ami-0ed56469b23a5a592"
    "us-west-2"      = "ami-0df7bb13ecfd294c0"
  }
}

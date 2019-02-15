variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-066c3c54d2b98b670"
    "eu-west-1"      = "ami-059cd5de8b205d94a"
    "us-east-1"      = "ami-0a9e571d6cb7d1e45"
    "us-east-2"      = "ami-0650a910f15be2819"
    "us-west-2"      = "ami-043b297a59fa12e49"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-07139076a8c77a216"
    "eu-west-1"      = "ami-0f10b3b9b9f77aee9"
    "us-east-1"      = "ami-08f822e1bdc7cb46b"
    "us-east-2"      = "ami-0e1ff7f55a515009d"
    "us-west-2"      = "ami-07b0da69c39c2cfbb"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-04ced742a0bac12d8"
    "eu-west-1"      = "ami-0ff09655b596b9c79"
    "us-east-1"      = "ami-0b968435bef896c03"
    "us-east-2"      = "ami-089b370abbb79d959"
    "us-west-2"      = "ami-0d051bfbcc2cc328c"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-04ae3294c445400b8"
    "eu-west-1"      = "ami-0454c6b2f311463dc"
    "us-east-1"      = "ami-0beac6d094fdc2bbb"
    "us-east-2"      = "ami-0400284db40e5e310"
    "us-west-2"      = "ami-05f7c2bbf2cfc977a"
  }
}

variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-021e416bad3d38053"
    "eu-west-1"      = "ami-0d50d3b9a219e4187"
    "us-east-1"      = "ami-0e3eb84b1b6340ba5"
    "us-east-2"      = "ami-09d46b3cd16126702"
    "us-west-2"      = "ami-02efbe48923c969ec"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0b85df770b9d6ddf9"
    "eu-west-1"      = "ami-0b16f7a1005aeb58e"
    "us-east-1"      = "ami-03094cc9221fe2931"
    "us-east-2"      = "ami-0f3b87e2ad414c65a"
    "us-west-2"      = "ami-0431593422daad988"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0e4b6e9acdae62894"
    "eu-west-1"      = "ami-04ed021e21cd60c7e"
    "us-east-1"      = "ami-0c6981b5df1a110d2"
    "us-east-2"      = "ami-0e504a06299947185"
    "us-west-2"      = "ami-03fbf276a54146f35"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-012bba7c914485113"
    "eu-west-1"      = "ami-0863772ba9bde0ec3"
    "us-east-1"      = "ami-0bbd6725c2c0843b1"
    "us-east-2"      = "ami-0ce1c3120107af664"
    "us-west-2"      = "ami-0ec355bfc31884ef4"
  }
}

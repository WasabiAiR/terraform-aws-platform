variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-06da37b7bd14503ef"
    "eu-west-1"      = "ami-0db4f5db45a53ebdd"
    "us-east-1"      = "ami-0dce74d77fa29f210"
    "us-east-2"      = "ami-05ed6aea5a2ed11c9"
    "us-west-2"      = "ami-02ae5bafd53f43a0b"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-00e105a13c1ff0a8c"
    "eu-west-1"      = "ami-0b92b37327f2aeb82"
    "us-east-1"      = "ami-0a6be3d8f7bf56f69"
    "us-east-2"      = "ami-0e8dfce53857432d4"
    "us-west-2"      = "ami-05cdf06c71a6b956a"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-04da93304be6508c3"
    "eu-west-1"      = "ami-0e73cdd0fa087638d"
    "us-east-1"      = "ami-025918dfe5e22985f"
    "us-east-2"      = "ami-0227911869b614f99"
    "us-west-2"      = "ami-0ada793114c3aeccc"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-063bfe9f8d02e0ef5"
    "eu-west-1"      = "ami-07d6a56330d868f0f"
    "us-east-1"      = "ami-070aee464495b0696"
    "us-east-2"      = "ami-03f2e3c034b08d3e8"
    "us-west-2"      = "ami-0eb87f73623e92612"
  }
}

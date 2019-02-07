variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0c7b10eb750c0dbb3"
    "eu-west-1"      = "ami-02743b2fcc033d111"
    "us-east-1"      = "ami-04e2230ee47770c87"
    "us-east-2"      = "ami-0e01bc4d2eb5f0b52"
    "us-west-2"      = "ami-0326faf5bc6f99360"
  }
}

variable "faces_amis" {
  type        = "map"
  description = "map of region to ami for faces nodes"

  default = {
    "ap-southeast-2" = "ami-0735710cbf43cd325"
    "eu-west-1"      = "ami-01f52bdbbacd9c571"
    "us-east-1"      = "ami-03cd50d329fc8d167"
    "us-east-2"      = "ami-07597effa369e15c2"
    "us-west-2"      = "ami-0db0a7f246a93b6e2"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0735710cbf43cd325"
    "eu-west-1"      = "ami-01f52bdbbacd9c571"
    "us-east-1"      = "ami-03cd50d329fc8d167"
    "us-east-2"      = "ami-07597effa369e15c2"
    "us-west-2"      = "ami-0e70e04b373bc1aa2"
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
    "ap-southeast-2" = "ami-0906781a38e2ca2bc"
    "eu-west-1"      = "ami-0b47aa3cfded35c79"
    "us-east-1"      = "ami-05523a39c159ec7cf"
    "us-east-2"      = "ami-0e0f2d3c32d88715a"
    "us-west-2"      = "ami-0923ad4faddba741f"
  }
}

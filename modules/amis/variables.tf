variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0cdd0110ec4394a17"
    "eu-west-1"      = "ami-0dbe442df817db4d6"
    "us-east-1"      = "ami-0293393e267c802c9"
    "us-east-2"      = "ami-003d4156a7d5e2466"
    "us-west-2"      = "ami-0986d557a08db81c7"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-0e39a3ef0f5ba9c93"
    "eu-west-1"      = "ami-02cf8ccdc3d033c7c"
    "us-east-1"      = "ami-034455c84bda8e391"
    "us-east-2"      = "ami-08964c02fe74f8748"
    "us-west-2"      = "ami-051dfddbec0c32083"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0b43e198c8789ccd5"
    "eu-west-1"      = "ami-0c50c2b9cc9597649"
    "us-east-1"      = "ami-06157519ffffe91e1"
    "us-east-2"      = "ami-00fcc74b3c5973264"
    "us-west-2"      = "ami-046c992ff6ddce686"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0b84c4f600bca77fa"
    "eu-west-1"      = "ami-0a8801eb11bf79cab"
    "us-east-1"      = "ami-0f42543816791919d"
    "us-east-2"      = "ami-01bb25fb597b96c8b"
    "us-west-2"      = "ami-073b77fd4b275074a"
  }
}

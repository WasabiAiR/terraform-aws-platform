variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0a46dc62f80576f54"
    "eu-west-1"      = "ami-0507d3effa0809ccb"
    "us-east-1"      = "ami-0704f3e544fb735f9"
    "us-east-2"      = "ami-0a89493fa6e1ad8f6"
    "us-west-2"      = "ami-04d9e7da60adbfb75"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-00c76e33763342072"
    "eu-west-1"      = "ami-01a5ae7c836f7e3d1"
    "us-east-1"      = "ami-077f57ef9318f2f4c"
    "us-east-2"      = "ami-0452115a3dd5c3b3b"
    "us-west-2"      = "ami-02c2aeeb7a12fe382"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0c64665f6139442f0"
    "eu-west-1"      = "ami-07ab497cd6a636dfa"
    "us-east-1"      = "ami-067ee54b9b4ae98ae"
    "us-east-2"      = "ami-0383445b88b57be90"
    "us-west-2"      = "ami-0b4c8737f063b0be1"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0105310728dd96828"
    "eu-west-1"      = "ami-045a71c6ea11bab84"
    "us-east-1"      = "ami-05e1ea09110186130"
    "us-east-2"      = "ami-01c47c9acd7a887cd"
    "us-west-2"      = "ami-034979978b2cab650"
  }
}

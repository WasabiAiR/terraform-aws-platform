variable "ecs_amis" {
  type        = "map"
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0a6934246116641c8"
    "eu-west-1"      = "ami-02236041261c56426"
    "us-east-1"      = "ami-0710dfd9cfc2335d1"
    "us-east-2"      = "ami-0868793c966c681a5"
    "us-west-2"      = "ami-009ec30cfac34c6a4"
  }
}

variable "mlservices_amis" {
  type        = "map"
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-08affba3291c616d7"
    "eu-west-1"      = "ami-0c932fe0e701047f7"
    "us-east-1"      = "ami-0f49b34ec42228d53"
    "us-east-2"      = "ami-030c7ad88003ae706"
    "us-west-2"      = "ami-07a23764fbda2643f"
  }
}

variable "proxy_amis" {
  type        = "map"
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0795f50b05c651aff"
    "eu-west-1"      = "ami-0bf7d137978121bff"
    "us-east-1"      = "ami-03af68dba6cf7ae8c"
    "us-east-2"      = "ami-048fd233025359464"
    "us-west-2"      = "ami-08f67b909a0d545fc"
  }
}

variable "services_amis" {
  type        = "map"
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0589314cfd889d8a7"
    "eu-west-1"      = "ami-03632df1531478381"
    "us-east-1"      = "ami-02674815aacc440fa"
    "us-east-2"      = "ami-01c55c2daf8c5b2ad"
    "us-west-2"      = "ami-0cfffd6f7c23cca12"
  }
}

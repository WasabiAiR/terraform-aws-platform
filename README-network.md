# Network Requirements

It is required that you use GrayMeta network module to create the network.

Example if you would like to use a different subnet.
```
locals {
  cidr_vpc = "10.10.0.0/16"
}

module "network" {
  source = "github.com/graymeta/terraform-aws-platform//modules/network?ref=v0.1.0"

  az1                  = "${local.az1}"
  az2                  = "${local.az2}"
  cidr_vpc             = "${local.cidr_vpc}"
  platform_instance_id = "${local.platform_instance_id}"
  region               = "${local.region}"

  # Proxy Cluster Configuration
  dns_name               = "${local.dns_name}"
  key_name               = "${local.key_name}"
  proxy_instance_type    = "m4.large"
  proxy_max_cluster_size = 2
  proxy_min_cluster_size = 1
  proxy_scale_down_thres = "12500000" # 100 Mb/s
  proxy_scale_up_thres   = "50000000" # 400 Mb/s
  ssh_cidr_blocks        = "${local.ssh_cidr_blocks}"

  # Subnets
  cidr_subnet_ecs_1           = "${cidrsubnet(local.cidr_vpc, 5, 1)}"
  cidr_subnet_ecs_2           = "${cidrsubnet(local.cidr_vpc, 5, 3)}"
  cidr_subnet_elasticsearch_1 = "${cidrsubnet(local.cidr_vpc, 8, 16)}"
  cidr_subnet_elasticsearch_2 = "${cidrsubnet(local.cidr_vpc, 8, 17)}"
  cidr_subnet_faces_1         = "${cidrsubnet(local.cidr_vpc, 8, 18)}"
  cidr_subnet_faces_2         = "${cidrsubnet(local.cidr_vpc, 8, 19)}"
  cidr_subnet_proxy_1         = "${cidrsubnet(local.cidr_vpc, 8, 20)}"
  cidr_subnet_proxy_2         = "${cidrsubnet(local.cidr_vpc, 8, 21)}"
  cidr_subnet_public_1        = "${cidrsubnet(local.cidr_vpc, 8, 0)}"
  cidr_subnet_public_2        = "${cidrsubnet(local.cidr_vpc, 8, 1)}"
  cidr_subnet_rds_1           = "${cidrsubnet(local.cidr_vpc, 8, 2)}"
  cidr_subnet_rds_2           = "${cidrsubnet(local.cidr_vpc, 8, 3)}"
  cidr_subnet_services_1      = "${cidrsubnet(local.cidr_vpc, 8, 4)}"
  cidr_subnet_services_2      = "${cidrsubnet(local.cidr_vpc, 8, 5)}"
}
```

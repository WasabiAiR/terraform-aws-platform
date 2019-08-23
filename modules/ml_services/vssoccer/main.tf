locals {
  api_name = "vssoccer"
  api_port = "10306"
  tfs_port = "11306"
}

module "ml_init" {
  source = "../ml_userdata"

  api_port        = "${local.api_port}"
  log_group       = "${var.ml_loadbalancer_output["ml_cloudwatch_log_group"]}"
  proxy_endpoint  = "${var.ml_loadbalancer_output["proxy_endpoint"]}"
  service_name    = "${local.api_name}"
  statsite_ip     = "${var.ml_loadbalancer_output["statsite_ip"]}"
  statsite_prefix = "${var.ml_loadbalancer_output["statsite_prefix"]}/${local.api_name}"
  tfs_port        = "${local.tfs_port}"
}

# Create the cluster
module "cluster" {
  source = "../ml_cluster"

  cloud_init             = "${module.ml_init.userdata}"
  instance_type          = "${var.instance_type}"
  max_cluster_size       = "${var.max_cluster_size}"
  min_cluster_size       = "${var.min_cluster_size}"
  ml_loadbalancer_output = "${var.ml_loadbalancer_output}"
  port                   = "${local.api_port}"
  service_name           = "${local.api_name}"
  services_ecs_cidrs     = "${var.services_ecs_cidrs}"
  user_init              = "${var.user_init}"
  volume_size            = "${var.volume_size}"
}

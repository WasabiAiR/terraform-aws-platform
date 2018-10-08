module "proxy" {
  source = "../proxy"

  allowed_cidrs = [
    "${aws_subnet.services_1.cidr_block}",
    "${aws_subnet.services_2.cidr_block}",
    "${aws_subnet.ecs.cidr_block}",
    "${aws_subnet.ecs_2.cidr_block}",
    "${aws_subnet.faces_1.cidr_block}",
    "${aws_subnet.faces_2.cidr_block}",
  ]

  dns_name                            = "${var.dns_name}"
  key_name                            = "${var.key_name}"
  log_retention                       = "${var.log_retention}"
  platform_instance_id                = "${var.platform_instance_id}"
  proxy_amis                          = "${lookup(var.proxy_amis, var.region)}"
  proxy_instance_type                 = "${var.proxy_instance_type}"
  proxy_max_cluster_size              = "${var.proxy_max_cluster_size}"
  proxy_min_cluster_size              = "${var.proxy_min_cluster_size}"
  proxy_scale_down_evaluation_periods = "${var.proxy_scale_down_evaluation_periods}"
  proxy_scale_down_period             = "${var.proxy_scale_down_period}"
  proxy_scale_down_thres              = "${var.proxy_scale_down_thres}"
  proxy_scale_up_evaluation_periods   = "${var.proxy_scale_up_evaluation_periods}"
  proxy_scale_up_period               = "${var.proxy_scale_up_period}"
  proxy_scale_up_thres                = "${var.proxy_scale_up_thres}"
  proxy_subnet_id_1                   = "${aws_subnet.proxy_1.id}"
  proxy_subnet_id_2                   = "${aws_subnet.proxy_2.id}"
  proxy_user_init                     = "${var.proxy_user_init}"
  proxy_volume_size                   = "${var.proxy_volume_size}"
  ssh_cidr_blocks                     = "${var.ssh_cidr_blocks}"
  whitelist                           = "${var.whitelist}"
}

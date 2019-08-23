module "statsite" {
  source = "../statsite"

  key_name               = "${var.key_name}"
  platform_instance_id   = "${var.platform_instance_id}"
  proxy_endpoint         = "${module.proxy.proxy_endpoint}"
  statsite_amis          = "${lookup(module.amis.proxy_amis, var.region)}"
  statsite_instance_type = "${var.statsite_instance_type}"
  statsite_subnet_id_1   = "${aws_subnet.services_1.id}"
  statsite_user_init     = "${var.proxy_user_init}"
  statsite_volume_size   = "${var.statsite_volume_size}"
  ssh_cidr_blocks        = "${var.ssh_cidr_blocks}"
}
# This module is used to create a generic for most of the ML Services.

# Generate the cloud-init script
data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    api_port        = "${var.api_port}"
    log_group       = "${var.log_group}"
    proxy_endpoint  = "${var.proxy_endpoint}"
    service_name    = "${var.service_name}"
    statsite_ip     = "${var.statsite_ip}"
    statsite_prefix = "${var.statsite_prefix}"
    tfs_port        = "${var.tfs_port}"
  }
}

# This cloud-init script is needed to tee the bootstap script to another log
# This is how amazon ami work.  Broke in centos.  This will work around that issue.
data "template_file" "init-logging" {
  template = "${file("${path.module}/userdata.tpl")}"
}

# bootstap script to install and setup graphite
data "template_file" "bootstrap" {
  template = "${file("${path.module}/userdata-bootstrap.sh")}"

  vars {
    proxy_endpoint = "${var.proxy_endpoint}"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-logging.rendered}"
  }

  part {
    content_type = "text/cloud-config"
    content      = "${var.statsite_user_init}"
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.bootstrap.rendered}"
  }
}

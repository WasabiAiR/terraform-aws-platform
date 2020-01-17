data "aws_caller_identity" "current" {}

data "template_file" "dashboard" {
  template = "${file("${path.module}/templates/dashboard.json")}"

  vars = {
    client_id            = "${data.aws_caller_identity.current.account_id}"
    es_domain            = "${var.es_domain}"
    platform_instance_id = "${var.platform_instance_id}"
    proxy_asg            = "${var.proxy_asg}"
    rds_name             = "${var.rds_name}"
    region               = "${var.region}"
    services_alb         = "${var.services_alb}"
    services_asg         = "${var.services_asg}"
  }
}

resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "${var.dashboard_name}"
  dashboard_body = "${data.template_file.dashboard.rendered}"
}

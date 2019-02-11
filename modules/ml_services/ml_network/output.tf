output "ml_loadbalancer_output" {
  value = {
    ml_alb_iam_profile_name  = "${aws_iam_instance_profile.iam_instance_profile_ml.name}"
    ml_alb_id                = "${aws_lb.ml_alb.id}"
    ml_alb_dns               = "${aws_lb.ml_alb.dns_name}"
    ml_alb_security_group_id = "${aws_security_group.ml_alb.id}"
    ml_cloudwatch_log_group  = "${aws_cloudwatch_log_group.ml.name}"
    mlservices_subnet_id_1   = "${var.mlservices_subnet_id_1}"
    mlservices_subnet_id_2   = "${var.mlservices_subnet_id_2}"
    platform_instance_id     = "${var.platform_instance_id}"
    vpc_id                   = "${data.aws_subnet.subnet_mlservices_1.vpc_id}"
    proxy_endpoint           = "${var.proxy_endpoint}"
    key_name                 = "${var.key_name}"
    ssh_cidr_blocks          = "${var.ssh_cidr_blocks}"
  }
}

output "endpoint" {
  value = "${aws_lb.ml_alb.dns_name}"
}

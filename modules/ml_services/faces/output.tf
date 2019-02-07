output "faces_endpoint" {
  value = "${var.ml_loadbalancer_output["ml_alb_dns"]}:${local.api_port}"
}

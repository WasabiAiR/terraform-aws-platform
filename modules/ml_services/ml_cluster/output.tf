output "endpoint" {
  value = "http://${var.ml_loadbalancer_output["ml_alb_dns"]}:${var.port}"
}

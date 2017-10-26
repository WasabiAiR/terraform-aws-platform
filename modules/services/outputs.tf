output "GrayMetaPlatformEndpoint" {
  value = "${aws_lb.services_alb.dns_name}"
}

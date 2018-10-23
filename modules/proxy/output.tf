output "proxy_endpoint" {
  value = "${aws_lb.proxy_lb.dns_name}:3128"
}

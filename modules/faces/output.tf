output "faces_endpoint" {
  value = "http://${aws_lb.faces_lb.dns_name}"
}

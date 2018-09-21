output "faces_endpoint" {
  value = "${aws_lb.faces_lb.dns_name}"
}

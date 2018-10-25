output "faces_endpoint" {
  value = "${aws_lb.faces_lb.dns_name}"
}

output "credits_endpoint" {
  value = "http://${aws_lb.faces_lb.dns_name}:10337"
}

output "slates_endpoint" {
  value = "http://${aws_lb.faces_lb.dns_name}:10338"
}
output "proxy_endpoint" {
  value = "${aws_lb.proxy_lb.dns_name}:3128"
}

output "proxy_asg" {
  value = "${aws_cloudformation_stack.proxy_asg.outputs["AsgName"]}"
}

output "GrayMetaPlatformEndpoint" {
  value = "${aws_lb.services_alb.dns_name}"
}

output "services_security_group_id" {
  value = "${aws_security_group.services.id}"
}

output "sns_topic_arn_harvest_complete" {
  value = "${aws_sns_topic.harvest_complete.arn}"
}

output "services_alb_cw" {
  value = "${aws_lb.services_alb.arn_suffix}"
}

output "services_asg" {
  value = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
}

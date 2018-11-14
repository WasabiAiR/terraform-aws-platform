output "GrayMetaPlatformEndpoint" {
  value = "${module.services.GrayMetaPlatformEndpoint}"
}

output "sns_topic_arn_harvest_complete" {
  value = "${module.services.sns_topic_arn_harvest_complete}"
}

output "OauthCallbackEndpoint" {
  value = "https://${var.dns_name}:8443/connect"
}

resource "aws_cloudwatch_log_group" "proxy" {
  name              = "GrayMetaPlatform-${var.platform_instance_id}-Proxy"
  retention_in_days = "${var.log_retention}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

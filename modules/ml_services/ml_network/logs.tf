resource "aws_cloudwatch_log_group" "ml" {
  name              = "GrayMetaPlatform-${var.platform_instance_id}-ML"
  retention_in_days = "${var.log_retention}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ML"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

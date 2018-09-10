resource "aws_cloudwatch_log_group" "faces" {
  name              = "GrayMetaPlatform-${var.platform_instance_id}-Faces"
  retention_in_days = "${var.log_retention}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_sns_topic" "harvest_complete" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-HarvestComplete"
}

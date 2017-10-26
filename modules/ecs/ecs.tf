resource "aws_ecs_cluster" "ecs_cluster" {
  name = "GrayMetaPlatform-${var.platform_instance_id}"
}

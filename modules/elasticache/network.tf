resource "aws_elasticache_subnet_group" "cache" {
  name       = "GrayMetaPlatform-${var.platform_instance_id}-cache"
  subnet_ids = ["${var.subnet_id_1}", "${var.subnet_id_2}"]
}

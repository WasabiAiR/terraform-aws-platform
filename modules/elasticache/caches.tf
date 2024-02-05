resource "aws_elasticache_cluster" "services" {
  cluster_id           = "gm-${var.platform_instance_id}"
  engine               = "redis"
  // engine_version       = "3.2.10"
  engine_version       = "7.0.7"
  node_type            = "${var.instance_type_services}"
  port                 = 6379
  num_cache_nodes      = 1
  security_group_ids   = ["${aws_security_group.elasticache.id}"]
  subnet_group_name    = "${aws_elasticache_subnet_group.cache.name}"
  parameter_group_name = "default.redis3.2"
}

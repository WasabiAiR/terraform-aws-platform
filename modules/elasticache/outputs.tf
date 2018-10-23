output "endpoint_services" {
  value = "${aws_elasticache_cluster.services.cache_nodes.0.address}"
}

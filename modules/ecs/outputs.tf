output "cluster" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}

output "temporary_bucket_name" {
  value = "${aws_s3_bucket.temp_bucket.id}"
}

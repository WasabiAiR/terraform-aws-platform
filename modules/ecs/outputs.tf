output "cluster" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}

output "temporary_bucket_name" {
  value = "${aws_s3_bucket.temp_bucket.id}"
}

output "temporary_bucket_arn" {
  value = "${aws_s3_bucket.temp_bucket.arn}"
}

output "ecs_security_group_id" {
  value = "${aws_security_group.ecs.id}"
}

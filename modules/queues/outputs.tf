output "activity" {
  value = "${aws_sqs_queue.activity.id}"
}

output "index" {
  value = "${aws_sqs_queue.index.id}"
}

output "stage" {
  value = "${aws_sqs_queue.stage.id}"
}

output "walk" {
  value = "${aws_sqs_queue.walk.id}"
}

output "activity_arn" {
  value = "${aws_sqs_queue.activity.arn}"
}

output "index_arn" {
  value = "${aws_sqs_queue.index.arn}"
}

output "stage_arn" {
  value = "${aws_sqs_queue.stage.arn}"
}

output "walk_arn" {
  value = "${aws_sqs_queue.walk.arn}"
}

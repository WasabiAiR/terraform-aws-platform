resource "aws_iam_policy" "iam_policy" {
  name        = "GrayMetaPlatform-${var.platform_instance_id}-Services-Policy"
  description = "GrayMeta Platform Services Nodes privileges"
  policy      = "${data.template_file.policy_services.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  roles      = ["${var.services_iam_role_name}"]
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}

resource "aws_iam_instance_profile" "iam_instance_profile_services" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-Services-InstanceProfile"
  role = "${var.services_iam_role_name}"
}

data "template_file" "policy_services" {
  template = "${file("${path.module}/policy-services.json.tpl")}"

  vars {
    aws_cust_labels_bucket_arn     = "${var.aws_cust_labels_bucket_arn}"
    file_storage_s3_bucket_arn     = "${var.file_storage_s3_bucket_arn}"
    log_storage_s3_bucket_arn      = "arn:aws:s3:::${var.cw_dest_bucket}"
    usage_s3_bucket_arn            = "${var.usage_s3_bucket_arn}"
    sns_topic_arn_harvest_complete = "${aws_sns_topic.harvest_complete.arn}"
    sqs_queues                     = "${join("\",\"", compact(list(var.sqs_activity_arn, var.sqs_index_arn, var.sqs_itemcleanup_arn, var.sqs_walk_arn, var.sqs_stage01_arn, var.sqs_stage02_arn, var.sqs_stage03_arn, var.sqs_stage04_arn, var.sqs_stage05_arn, var.sqs_stage06_arn, var.sqs_stage07_arn, var.sqs_stage08_arn, var.sqs_stage09_arn, var.sqs_stage10_arn, var.sqs_s3notifications_arn)))}"
    temporary_bucket_arn           = "${var.temporary_bucket_arn}"
    from_addr                      = "${var.notifications_from_addr}"
  }
}

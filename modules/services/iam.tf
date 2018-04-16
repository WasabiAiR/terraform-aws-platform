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
    file_storage_s3_bucket_arn     = "${var.file_storage_s3_bucket_arn}"
    usage_s3_bucket_arn            = "${var.usage_s3_bucket_arn}"
    sns_topic_arn_harvest_complete = "${aws_sns_topic.harvest_complete.arn}"
    sqs_activity_arn               = "${var.sqs_activity_arn}"
    sqs_index_arn                  = "${var.sqs_index_arn}"
    sqs_stage_arn                  = "${var.sqs_stage_arn}"
    sqs_walk_arn                   = "${var.sqs_walk_arn}"
    from_addr                      = "${var.notifications_from_addr}"
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = "${file("${path.module}/policy-assume-role.json")}"
}

resource "aws_iam_policy" "iam_policy" {
  description = "GrayMeta Platform Services Nodes privileges"
  policy      = "${data.template_file.policy_services.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}

resource "aws_iam_instance_profile" "iam_instance_profile_services" {
  role = "${aws_iam_role.iam_role.name}"
}

data "template_file" "policy_services" {
    template = "${file("${path.module}/policy-services.json.tpl")}"
    vars {
        file_storage_s3_bucket_arn = "${var.file_storage_s3_bucket_arn}"
        sqs_activity_arn           = "${var.sqs_activity_arn}"
        sqs_index_arn              = "${var.sqs_index_arn}"
        sqs_stage_arn              = "${var.sqs_stage_arn}"
        sqs_walk_arn               = "${var.sqs_walk_arn}"
        from_addr                  = "${var.notifications_from_addr}"
    }
}

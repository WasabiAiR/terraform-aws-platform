resource "aws_iam_role" "iam_role" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS-AssumeRole"
  assume_role_policy = "${file("${path.module}/policy-assume-role.json")}"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "GrayMetaPlatform-${var.platform_instance_id}-ECS-Policy"
  description = "GrayMeta Platform ECS privileges"
  policy      = "${data.template_file.policy_ecs.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}

resource "aws_iam_instance_profile" "iam_instance_profile_ecs" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-ECS-InstanceProfile"
  role = "${aws_iam_role.iam_role.name}"
}

data "template_file" "policy_ecs" {
  template = "${file("${path.module}/policy-ecs.json.tpl")}"

  vars {
    bucket_arn = "${aws_s3_bucket.temp_bucket.arn}"
  }
}

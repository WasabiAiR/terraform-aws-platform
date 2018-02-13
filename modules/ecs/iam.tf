resource "aws_iam_role" "iam_role" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS-AssumeRole"
  assume_role_policy = "${file("${path.module}/policy-assume-role.json")}"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "GrayMetaPlatform-${var.platform_instance_id}-ECS-Policy"
  description = "GrayMeta Platform ECS privileges"
  policy      = "${file("${path.module}/policy-ecs.json")}"
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

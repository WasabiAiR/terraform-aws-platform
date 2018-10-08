resource "aws_iam_role" "iam_role" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-AssumeRole"
  assume_role_policy = "${file("${path.module}/policy-assume-role.json")}"
}

resource "aws_iam_policy" "iam_policy" {
  description = "GrayMeta Platform Proxy Nodes privileges"
  name        = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-Policy"
  policy      = "${data.template_file.policy_proxy.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
  roles      = ["${aws_iam_role.iam_role.name}"]
}

resource "aws_iam_instance_profile" "iam_instance_profile_proxy" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-InstanceProfile"
  role = "${aws_iam_role.iam_role.name}"
}

data "template_file" "policy_proxy" {
  template = "${file("${path.module}/policy-proxy.json.tpl")}"
}

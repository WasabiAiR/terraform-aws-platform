resource "aws_iam_policy" "iam_policy" {
  description = "GrayMeta Platform Faces Nodes privileges"
  name        = "GrayMetaPlatform-${var.platform_instance_id}-Faces-Policy"
  policy      = "${data.template_file.policy_faces.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
  roles      = ["${var.faces_iam_role_name}"]
}

resource "aws_iam_instance_profile" "iam_instance_profile_faces" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-Faces-InstanceProfile"
  role = "${var.faces_iam_role_name}"
}

data "template_file" "policy_faces" {
  template = "${file("${path.module}/policy-faces.json.tpl")}"
}

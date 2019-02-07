module "mliam" {
  source = "../iam"

  platform_instance_id = "${var.platform_instance_id}"
}

resource "aws_iam_policy" "iam_policy" {
  description = "GrayMeta Platform ML Nodes privileges"
  name        = "GrayMetaPlatform-${var.platform_instance_id}-ML-Policy"
  policy      = "${data.template_file.policy_ml.rendered}"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${aws_iam_policy.iam_policy.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
  roles      = ["${module.mliam.ml_iam_role_name}"]
}

resource "aws_iam_instance_profile" "iam_instance_profile_ml" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-ML-InstanceProfile"
  role = "${module.mliam.ml_iam_role_name}"
}

data "template_file" "policy_ml" {
  template = "${file("${path.module}/policy-ml.json.tpl")}"
}

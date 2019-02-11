resource "aws_iam_role" "iam_role" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-ML-AssumeRole"
  assume_role_policy = "${file("${path.module}/policy-assume-role.json")}"
}

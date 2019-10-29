data "template_file" "policy_usage" {
  template = "${file("${path.module}/policy-usage.json.tpl")}"

  vars {
    usage_s3_bucket_arn = "${var.usage_s3_bucket_arn}"
    graymeta_account    = "${var.graymeta_account}"
  }
}

resource "aws_s3_bucket_policy" "usage" {
  bucket = "${element(split(":", var.usage_s3_bucket_arn), length(split(":", var.usage_s3_bucket_arn)) - 1)}"
  policy = "${data.template_file.policy_usage.rendered}"
}

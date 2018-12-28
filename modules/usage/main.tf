data "aws_s3_bucket" "usage" {
  bucket = "${var.usage_s3_bucket_id}"
}

data "template_file" "policy_usage" {
  template = "${file("${path.module}/policy-usage.json.tpl")}"

  vars {
    usage_s3_bucket_arn = "${data.aws_s3_bucket.usage.arn}"
  }
}

resource "aws_s3_bucket_policy" "usage" {
  bucket = "${var.usage_s3_bucket_id}"
  policy = "${data.template_file.policy_usage.rendered}"
}

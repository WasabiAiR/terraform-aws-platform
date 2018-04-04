resource "aws_s3_bucket" "temp_bucket" {
  bucket_prefix = "graymeta-${var.platform_instance_id}-"
  acl           = "private"
  region        = "${var.region}"

  lifecycle_rule {
    id      = "objects"
    enabled = true

    expiration {
      days = 7
    }
  }
}

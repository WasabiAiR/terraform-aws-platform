resource "aws_s3_bucket" "temp_bucket" {
  bucket_prefix = "graymeta-${lower(var.platform_instance_id)}-"
  acl           = "private"
  region        = "${var.region}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  
  lifecycle_rule {
    id      = "objects"
    enabled = true

    expiration {
      days = 7
    }
  }
}

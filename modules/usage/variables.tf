variable "graymeta_account" {
  type        = "string"
  description = "The GrayMeta account number that will have permission to read the Usage bucket"
  default     = "913397769129"
}

variable "usage_s3_bucket_arn" {
  type        = "string"
  description = "The Usage bucket ARN"
}

variable "platform_instance_id" {}
variable "bucket_arn" {}
variable "queue_name" {}
variable "region" {}
variable "filter_prefix" {}
variable "filter_suffix" {}

provider "aws" {
    region = "${var.region}"
}

data "aws_s3_bucket" "bucket" {
    bucket = "${element(split(":", var.bucket_arn), length(split(":", var.bucket_arn)) - 1)}"
}

data "aws_sqs_queue" "queue" {
  name = "${element(split("/", var.queue_name), length(split("/", var.queue_name)) - 1)}"
}

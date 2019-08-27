# Setting up s3 ObjectCreated notifications

## Prerequisites:

* An s3 bucket's ARN

## Procedure:

Assume we want to set up notifications for the bucket with ARN `arn:aws:s3:::somebucket` and only trigger notifications from the `logs/` prefix that have the `.txt` suffix.

Add this block to your terraform code:

```
resource "aws_sqs_queue" "my_notification_queue" {
    name = "my-notifications-queue"
}

module "s3_sqs" {
    source = "github.com/graymeta/terraform-aws-platform//modules/s3_sqs?ref=v0.1.12"

    platform_instance_id = "${local.platform_instance_id}"
    region               = "${local.region}"
    
    bucket_arn           = "arn:aws:s3:::somebucket"
    queue_name           = "${aws_sqs_queue.my_notification_queue.id}"
    filter_prefix        = "logs/"
    filter_suffix        = ".txt"
}
```

* `platform_instance_id` - (string) - unique identifier for this instance of the platform
* `region` - (string) - AWS region
* `bucket_arn` - (string) - The ARN of the bucket to monitor
* `queue_name` - (string) - The name of the SQS queue to put the notifications into
* `filter_prefix` - (string) - Optional. The prefix that the s3 keys must match to trigger a notification. Leave blank if you want all items in the bucket to trigger notifications.
* `filter_suffix` - (string) - Optional. The suffix that the s3 keys must match to trigger a notification. Leave blank if you want all items in the bucket to trigger notifications.

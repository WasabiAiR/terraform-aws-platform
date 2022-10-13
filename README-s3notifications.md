# Triggering harvests via s3 ObjectCreated notifications

## Prerequisite:

* s3 bucket configured with notifications for ObjectCreated\* events that get published to an SQS queue. If you do not have this set up already, see [here](README-s3notifications-setup.md)
* s3 bucket has been added as a storage location inside the GrayMeta Platform and the container is toggled into the `on` state

## Configuration

Set the following variables when instantiating the module:

```
module "platform" {
    source = "github.com/graymeta/terraform-aws-platform?ref=v0.2.6"
    ...
    # (Optional) s3 notification
    sqs_s3notifications_arn = ""
    sqs_s3notifications     = ""
    s3subscriber_priority   = ""
    ...
}
```

* `sqs_s3notifications_arn` - (string) - The ARN of the SQS queue that the s3 ObjectCreated notifications will be read from
* `sqs_s3notifications` - (string) - The https endpoint of the SQS queue that the s3 ObjectCreated notifications will be read from
* `s3subscriber_priority` - (integer) - Optional. The priority to assign harvest jobs being scheduled from s3 ObjectCreated notifications. Valid values are 1 through 10 (1=highest priority). If not set, uses the platform default priority level (5).

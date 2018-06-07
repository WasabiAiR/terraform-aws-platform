resource "aws_sns_topic" "topic" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-s3notifications-${data.aws_s3_bucket.bucket.id}"
}

resource "aws_sns_topic_policy" "default" {
  arn    = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.sns-topic-policy.json}"
}

data "aws_iam_policy_document" "sns-topic-policy" {
  statement {
    actions = [
      "SNS:Publish",
    ]

    condition {
      test     = "ArnEquals"
      variable = "AWS:SourceARN"

      values = [
        "${data.aws_s3_bucket.bucket.arn}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.topic.arn}",
    ]

    sid = "allow_publish"
  }

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:Receive",
    ]

    condition {
      test     = "StringLike"
      variable = "SNS:Endpoint"

      values = [
        "${aws_sns_topic.topic.arn}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${data.aws_sqs_queue.queue.arn}",
    ]

    sid = "allow_subscription"
  }
}

resource "aws_sns_topic_subscription" "sqs_target" {
  topic_arn = "${aws_sns_topic.topic.arn}"
  protocol  = "sqs"
  endpoint  = "${data.aws_sqs_queue.queue.arn}"
}

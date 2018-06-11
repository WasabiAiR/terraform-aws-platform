data "aws_iam_policy_document" "sqs-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SQS:SendMessage",
    ]

    condition {
      test     = "ArnEquals"
      variable = "AWS:SourceARN"

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
  }
}

resource "aws_sqs_queue_policy" "sqs-policy" {
  queue_url = "${data.aws_sqs_queue.queue.id}"
  policy    = "${data.aws_iam_policy_document.sqs-policy.json}"
}

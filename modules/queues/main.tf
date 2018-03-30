resource "aws_sqs_queue" "activity" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-activity"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "index" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-index"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "walk" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-walk"
  message_retention_seconds = 1209600
}

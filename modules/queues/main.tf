resource "aws_sqs_queue" "activity" {
    name = "GrayMetaPlatform-${var.platform_instance_id}-activity"
}

resource "aws_sqs_queue" "index" {
    name = "GrayMetaPlatform-${var.platform_instance_id}-index"
}

resource "aws_sqs_queue" "stage" {
    name = "GrayMetaPlatform-${var.platform_instance_id}-stage"
}

resource "aws_sqs_queue" "walk" {
    name = "GrayMetaPlatform-${var.platform_instance_id}-walk"
}

resource "aws_sqs_queue" "activity" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-activity"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "index" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-index"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage01" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage01"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage02" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage02"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage03" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage03"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage04" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage04"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage05" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage05"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage06" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage06"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage07" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage07"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage08" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage08"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage09" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage09"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "stage10" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-stage10"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "walk" {
  name                      = "GrayMetaPlatform-${var.platform_instance_id}-walk"
  message_retention_seconds = 1209600
}

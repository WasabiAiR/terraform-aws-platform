resource "aws_cloudwatch_log_group" "services" {
    name              = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    retention_in_days = 7

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
        ApplicationName    = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

# Create the ECS log group here, because it is injected into the task definition when scheduled
# launches the job
resource "aws_cloudwatch_log_group" "ecs" {
    name              = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    retention_in_days = 7

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
        ApplicationName    = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

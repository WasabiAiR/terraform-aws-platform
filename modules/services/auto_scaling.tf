# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "services_asg" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-Services-ASG"
  timeout_in_minutes = "90"

  timeouts {
    create = "90m"
    update = "90m"
  }

  template_body = <<EOF
{
  "Resources": {
    "AutoScalingGroup": {
      "Type": "AWS::AutoScaling::AutoScalingGroup",
      "Properties": {
        "LaunchConfigurationName": "${aws_launch_configuration.launch_config_services.name}",
        "MaxSize": "${var.max_cluster_size}",
        "MinSize": "${var.min_cluster_size}",
        "Tags": [
          {
            "Key": "Name",
            "Value": "GrayMetaPlatform-${var.platform_instance_id}-Services",
            "PropagateAtLaunch": true
          },
          {
            "Key": "ApplicationName",
            "Value": "GrayMetaPlatform",
            "PropagateAtLaunch": true
          },
          {
            "Key": "PlatformInstanceID",
            "Value": "${var.platform_instance_id}",
            "PropagateAtLaunch": true
          }
        ],
        "TargetGroupARNs": [
            "${aws_lb_target_group.port80.arn}",
            "${aws_lb_target_group.port7000.arn}",
            "${aws_lb_target_group.port9090.arn}"
        ],
        "TerminationPolicies": [
          "OldestLaunchConfiguration",
          "OldestInstance",
          "Default"
        ],
        "VPCZoneIdentifier": [
            "${var.subnet_id_1}",
            "${var.subnet_id_2}"
        ]
      },
      "UpdatePolicy": {
        "AutoScalingRollingUpdate": {
          "MinInstancesInService": "${var.min_cluster_size}",
          "MaxBatchSize": "2",
          "PauseTime": "PT0S"
        }
      }
    }
  },
  "Outputs": {
    "AsgName": {
      "Description": "The name of the auto scaling group",
      "Value": {
        "Ref": "AutoScalingGroup"
      }
    }
  }
}
EOF
}

resource "aws_launch_configuration" "launch_config_services" {
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-Services-"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile_services.name}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.services.id}"]
  user_data            = "${data.template_file.userdata.rendered}"
  depends_on           = ["aws_cloudwatch_log_group.services", "aws_cloudwatch_log_group.ecs"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 50
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    box_client_id                  = "${var.box_client_id}"
    box_client_secret              = "${var.box_client_secret}"
    client_secret_fe               = "${var.client_secret_fe}"
    client_secret_internal         = "${var.client_secret_internal}"
    db_endpoint                    = "${var.db_endpoint}"
    db_password                    = "${var.db_password}"
    db_username                    = "${var.db_username}"
    dns_name                       = "${var.dns_name}"
    ecs_cluster                    = "${var.ecs_cluster}"
    ecs_cpu_reservation            = "${var.ecs_cpu_reservation}"
    ecs_memory_hard_reservation    = "${var.ecs_memory_hard_reservation}"
    ecs_memory_soft_reservation    = "${var.ecs_memory_soft_reservation}"
    ecs_log_group                  = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    elasticache_facebox            = "${var.elasticache_facebox}"
    elasticache_services           = "${var.elasticache_services}"
    elasticsearch_endpoint         = "${var.elasticsearch_endpoint}"
    encrypted_config_blob          = "${var.encrypted_config_blob}"
    encryption_key                 = "${var.encryption_key}"
    facebox_key                    = "${var.facebox_key}"
    file_storage_s3_bucket_arn     = "${var.file_storage_s3_bucket_arn}"
    from_addr                      = "${var.notifications_from_addr}"
    google_maps_key                = "${var.google_maps_key}"
    gm_env                         = "${var.customer}-${var.platform_instance_id}"
    gm_usage_prefix                = "${var.customer}-${var.platform_instance_id}"
    gm_walkd_max_item_concurrency  = "${var.gm_walkd_max_item_concurrency}"
    gm_walkd_redis_max_active      = "${var.gm_walkd_redis_max_active}"
    harvest_complete_stow_fields   = "${var.harvest_complete_stow_fields}"
    harvest_polling_time           = "${var.harvest_polling_time}"
    jwt_key                        = "${var.jwt_key}"
    region                         = "${var.region}"
    rollbar_token                  = "${var.rollbar_token}"
    s3subscriber_priority          = "${var.s3subscriber_priority}"
    services_log_group             = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    sns_topic_arn_harvest_complete = "${aws_sns_topic.harvest_complete.arn}"
    sqs_activity                   = "${var.sqs_activity}"
    sqs_index                      = "${var.sqs_index}"
    sqs_notifications              = "${var.sqs_s3notifications}"
    sqs_stage                      = "${var.sqs_stage01},${var.sqs_stage02},${var.sqs_stage03},${var.sqs_stage04},${var.sqs_stage05},${var.sqs_stage06},${var.sqs_stage07},${var.sqs_stage08},${var.sqs_stage09},${var.sqs_stage10}"
    sqs_walk                       = "${var.sqs_walk}"
    temporary_bucket_name          = "${var.temporary_bucket_name}"
    usage_s3_bucket_arn            = "${var.usage_s3_bucket_arn}"
    walkd_item_batch_size          = "${var.walkd_item_batch_size}"
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
  }
}

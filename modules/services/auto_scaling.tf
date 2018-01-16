# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "services_asg" {
    name               = "GrayMetaPlatform-${var.platform_instance_id}-Services-ASG"
    timeout_in_minutes = "90"
    timeouts {
        create = "90m"
        update = "90m"
    }
    template_body      = <<EOF
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
    name_prefix           = "GrayMetaPlatform-${var.platform_instance_id}-Services-"
    image_id              = "${var.ami_id}"
    instance_type         = "${var.instance_type}"
    iam_instance_profile  = "${aws_iam_instance_profile.iam_instance_profile_services.name}"
    key_name              = "${var.key_name}"
    security_groups       = ["${aws_security_group.services.id}"]
    user_data             = "${data.template_file.userdata.rendered}"
    depends_on            = ["aws_cloudwatch_log_group.services", "aws_cloudwatch_log_group.ecs"]
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
        azure_emotion_key                = "${var.azure_emotion_key}"
        azure_face_api_key               = "${var.azure_face_api_key}"
        azure_vision_key                 = "${var.azure_vision_key}"
        client_secret_fe                 = "${var.client_secret_fe}"
        client_secret_internal           = "${var.client_secret_internal}"
        db_endpoint                      = "${var.db_endpoint}"
        db_password                      = "${var.db_password}"
        db_username                      = "${var.db_username}"
        dns_name                         = "${var.dns_name}"
        ecs_cluster                      = "${var.ecs_cluster}"
        ecs_log_group                    = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
        elasticache_facebox              = "${var.elasticache_facebox}"
        elasticache_services             = "${var.elasticache_services}"
        elasticsearch_endpoint           = "${var.elasticsearch_endpoint}"
        encryption_key                   = "${var.encryption_key}"
        facebox_key                      = "${var.facebox_key}"
        file_storage_s3_bucket_arn       = "${var.file_storage_s3_bucket_arn}"
        from_addr                        = "${var.notifications_from_addr}"
        geonames_user                    = "${var.geonames_user}"
        geonames_user                    = "${var.geonames_user}"
        google_maps_key                  = "${var.google_maps_key}"
        google_maps_key                  = "${var.google_maps_key}"
        google_speech_auth_json          = "${var.google_speech_auth_json}"
        google_speech_bucket             = "${var.google_speech_bucket}"
        google_speech_project_id         = "${var.google_speech_project_id}"
        google_vision_features           = "${var.google_vision_features}"
        google_vision_key                = "${var.google_vision_key}"
        gm_env                           = "${var.customer}-${var.platform_instance_id}"
        jwt_key                          = "${var.jwt_key}"
        languageid_apptek_host           = "${var.languageid_apptek_host}"
        languageid_apptek_password       = "${var.languageid_apptek_password}"
        languageid_apptek_segment_length = "${var.languageid_apptek_segment_length}"
        languageid_apptek_username       = "${var.languageid_apptek_username}"
        microsoft_speech_api_key         = "${var.microsoft_speech_api_key}"
        pic_purify_key                   = "${var.pic_purify_key}"
        pic_purify_tasks                 = "${var.pic_purify_tasks}"
        region                           = "${data.aws_region.current.name}"
        rollbar_token                    = "${var.rollbar_token}"
        safety_dm_host                   = "${var.safety_dm_host}"
        safety_dm_pass                   = "${var.safety_dm_pass}"
        safety_dm_user                   = "${var.safety_dm_user}"
        services_log_group               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
        speech_apptek_concurrency        = "${var.speech_apptek_concurrency}"
        speech_apptek_host               = "${var.speech_apptek_host}"
        speech_apptek_password           = "${var.speech_apptek_password}"
        speech_apptek_username           = "${var.speech_apptek_username}"
        sqs_activity                     = "${var.sqs_activity}"
        sqs_index                        = "${var.sqs_index}"
        sqs_stage                        = "${var.sqs_stage}"
        sqs_walk                         = "${var.sqs_walk}"
        watson_speech_password           = "${var.watson_speech_password}"
        watson_speech_password           = "${var.watson_speech_password}"
        watson_speech_username           = "${var.watson_speech_username}"
        watson_speech_username           = "${var.watson_speech_username}"
        weather_api_key                  = "${var.weather_api_key}"
        weather_api_key                  = "${var.weather_api_key}"
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

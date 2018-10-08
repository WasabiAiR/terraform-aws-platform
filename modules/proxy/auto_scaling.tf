# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "proxy_asg" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-ASG"
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
        "LaunchConfigurationName": "${aws_launch_configuration.launch_config_proxy.name}",
        "MaxSize": "${var.proxy_max_cluster_size}",
        "MinSize": "${var.proxy_min_cluster_size}",
        "Tags": [
          {
            "Key": "Name",
            "Value": "GrayMetaPlatform-${var.platform_instance_id}-Proxy",
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
            "${aws_lb_target_group.port3128.arn}"
        ],
        "TerminationPolicies": [
          "OldestLaunchConfiguration",
          "OldestInstance",
          "Default"
        ],
        "VPCZoneIdentifier": [
            "${var.proxy_subnet_id_1}",
            "${var.proxy_subnet_id_2}"
        ]
      },
      "UpdatePolicy": {
        "AutoScalingRollingUpdate": {
          "MinInstancesInService": "${var.proxy_min_cluster_size}",
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

resource "aws_launch_configuration" "launch_config_proxy" {
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile_proxy.name}"

  image_id      = "${var.proxy_amis}"
  instance_type = "${var.proxy_instance_type}"
  key_name      = "${var.key_name}"
  name_prefix   = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.proxy_volume_size}"
    delete_on_termination = true
  }

  security_groups  = ["${aws_security_group.proxy.id}"]
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_cloudwatch_log_group.proxy"]
}

data "template_cloudinit_config" "config" {
  base64_encode = true
  gzip          = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata.rendered}"
  }

  part {
    content_type = "text/cloud-config"
    content      = "${var.proxy_user_init}"
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    log_group = "${aws_cloudwatch_log_group.proxy.name}"
    region    = "${data.aws_region.current.name}"
    dns_name  = "${var.dns_name}"
    whitelist = "${join("\n", formatlist("        %s",var.whitelist))}"
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.proxy_asg.outputs["AsgName"]}"
  cooldown               = 60
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-scale-up"
  scaling_adjustment     = 1
}

resource "aws_autoscaling_policy" "scale_down" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.proxy_asg.outputs["AsgName"]}"
  cooldown               = 180
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-scale-down"
  scaling_adjustment     = -1
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.proxy_scale_up_evaluation_periods}"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "${var.proxy_scale_up_period}"
  statistic           = "Average"
  threshold           = "${var.proxy_scale_up_thres}"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.proxy_asg.outputs["AsgName"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Proxy-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "${var.proxy_scale_down_evaluation_periods}"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "${var.proxy_scale_down_period}"
  statistic           = "Average"
  threshold           = "${var.proxy_scale_down_thres}"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.proxy_asg.outputs["AsgName"]}"
  }
}

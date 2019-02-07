# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "asg" {
  name               = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}-ASG"
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
        "LaunchConfigurationName": "${aws_launch_configuration.launch_config_cluster.name}",
        "MaxSize": "${var.max_cluster_size}",
        "MinSize": "${var.min_cluster_size}",
        "Tags": [
          {
            "Key": "Name",
            "Value": "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}",
            "PropagateAtLaunch": true
          },
          {
            "Key": "ApplicationName",
            "Value": "GrayMetaPlatform",
            "PropagateAtLaunch": true
          },
          {
            "Key": "PlatformInstanceID",
            "Value": "${var.ml_loadbalancer_output["platform_instance_id"]}",
            "PropagateAtLaunch": true
          }
        ],
        "TargetGroupARNs": [
            "${aws_lb_target_group.cluster.arn}"
        ],
        "TerminationPolicies": [
          "OldestLaunchConfiguration",
          "OldestInstance",
          "Default"
        ],
        "VPCZoneIdentifier": [
            "${var.ml_loadbalancer_output["mlservices_subnet_id_1"]}",
            "${var.ml_loadbalancer_output["mlservices_subnet_id_2"]}"
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

# Merge the cloud-init variables
data "template_cloudinit_config" "config" {
  base64_encode = true
  gzip          = true

  part {
    content_type = "text/cloud-config"
    content      = "${var.cloud_init}"
  }

  part {
    content_type = "text/cloud-config"
    content      = "${var.user_init}"
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

# Pull the AMI information
module "amis" {
  source = "../../amis"
}

# Create the Launch configuration for the ASG
resource "aws_launch_configuration" "launch_config_cluster" {
  iam_instance_profile = "${var.ml_loadbalancer_output["ml_alb_iam_profile_name"]}"
  image_id             = "${lookup(module.amis.mlservices_amis, data.aws_region.current.name)}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ml_loadbalancer_output["key_name"]}"
  name_prefix          = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size}"
    delete_on_termination = true
  }

  security_groups  = ["${aws_security_group.cluster.id}"]
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create the scale_up and scale_down policies
resource "aws_autoscaling_policy" "scale_up" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
  cooldown               = 60
  name                   = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}-scale-up"
  scaling_adjustment     = 1
}

resource "aws_autoscaling_policy" "scale_down" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
  cooldown               = 180
  name                   = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}-scale-down"
  scaling_adjustment     = -1
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
  }
}

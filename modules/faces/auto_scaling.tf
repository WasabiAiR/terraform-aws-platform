# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "faces_asg" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-Faces-ASG"
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
        "LaunchConfigurationName": "${aws_launch_configuration.launch_config_faces.name}",
        "MaxSize": "${var.faces_max_cluster_size}",
        "MinSize": "${var.faces_min_cluster_size}",
        "Tags": [
          {
            "Key": "Name",
            "Value": "GrayMetaPlatform-${var.platform_instance_id}-Faces",
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
            "${aws_lb_target_group.port10336.arn}"
        ],
        "TerminationPolicies": [
          "OldestLaunchConfiguration",
          "OldestInstance",
          "Default"
        ],
        "VPCZoneIdentifier": [
            "${var.faces_subnet_id_1}",
            "${var.faces_subnet_id_2}"
        ]
      },
      "UpdatePolicy": {
        "AutoScalingRollingUpdate": {
          "MinInstancesInService": "${var.faces_min_cluster_size}",
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

resource "aws_launch_configuration" "launch_config_faces" {
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile_faces.name}"
  image_id             = "${lookup(var.faces_amis, data.aws_region.current.name)}"
  instance_type        = "${var.faces_instance_type}"
  key_name             = "${var.key_name}"
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.faces_volume_size}"
    delete_on_termination = true
  }

  security_groups  = ["${aws_security_group.faces.id}"]
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_cloudwatch_log_group.faces"]
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
    content      = "${var.faces_user_init}"
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    dataversion      = "1"
    log_group        = "${aws_cloudwatch_log_group.faces.name}"
    postgresdb       = "faces"
    postgresendpoint = "${element(split(":", "${aws_db_instance.rds.endpoint}"), 0)}"
    postgrespass     = "${var.rds_db_password}"
    postgresport     = 5432
    postgresuser     = "${var.rds_db_username}"
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  cooldown               = 60
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-up"
  scaling_adjustment     = 1
}

resource "aws_autoscaling_policy" "scale_down" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  cooldown               = 180
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-down"
  scaling_adjustment     = -1
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  }
}

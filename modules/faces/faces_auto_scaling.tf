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
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-"
  image_id             = "${var.faces_ami_id}"
  instance_type        = "${var.faces_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile_faces.name}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.faces.id}"]
  user_data_base64     = "${data.template_cloudinit_config.config.rendered}"
  depends_on           = ["aws_cloudwatch_log_group.faces"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.faces_volume_size}"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

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
    postgresendpoint = "${element(split(":", "${aws_db_instance.rds.endpoint}"), 0)}"
    postgresport     = 5432
    postgresuser     = "${var.rds_db_username}"
    postgrespass     = "${var.rds_db_password}"
    postgresdb       = "faces"
    dataversion      = "1"
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 180
  autoscaling_group_name = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Faces-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_cloudformation_stack.faces_asg.outputs["AsgName"]}"
  }
}

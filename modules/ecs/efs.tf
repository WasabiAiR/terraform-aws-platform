resource "aws_efs_file_system" "ecs_filesystem" {
    performance_mode = "generalPurpose"

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}-EFS"
        ApplicationName    = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

resource "aws_security_group" "allow_efs" {
    description = "Allow ECS cluster to access EFS filesystem via NFS"
    vpc_id      = "${data.aws_subnet.ecs_subnet.vpc_id}"

    ingress {
        from_port   = 2049
        to_port     = 2049
        protocol    = "tcp"
        cidr_blocks = ["${data.aws_subnet.ecs_subnet.cidr_block}"]
    }

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}-EFS"
        ApplicationName    = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

resource "aws_efs_mount_target" "efs_mt" {
    file_system_id  = "${aws_efs_file_system.ecs_filesystem.id}"
    subnet_id       = "${var.subnet_id}"
    security_groups = ["${aws_security_group.allow_efs.id}"]
}

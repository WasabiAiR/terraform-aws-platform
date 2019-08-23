resource "aws_instance" "statsite" {
  ami                    = "${var.statsite_amis}"
  instance_type          = "${var.statsite_instance_type}"
  user_data              = "${data.template_cloudinit_config.config.rendered}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.statsite.id}"]
  subnet_id              = "${var.statsite_subnet_id_1}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.statsite_volume_size}"
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Statsite"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }

  volume_tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Statsite"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }

  lifecycle {
    ignore_changes = [
      "ami",
    ]
  }
}

resource "aws_security_group" "cluster" {
  description = "Access to ${var.service_name} nodes"
  vpc_id      = "${var.ml_loadbalancer_output["vpc_id"]}"

  tags {
    Name               = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.ml_loadbalancer_output["platform_instance_id"]}"
  }
}

# Allow all outbound traffic
resource "aws_security_group_rule" "egress" {
  description       = "Allow all outbound"
  security_group_id = "${aws_security_group.cluster.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow incoming ssh
resource "aws_security_group_rule" "allow_ssh" {
  description       = "allow-ssh"
  security_group_id = "${aws_security_group.cluster.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${split(",", var.ml_loadbalancer_output["ssh_cidr_blocks"])}"]
}

# Allow incoming ML Loadbalancer
resource "aws_security_group_rule" "allow_ml_alb" {
  description              = "allow-ML-ALB"
  security_group_id        = "${aws_security_group.cluster.id}"
  source_security_group_id = "${var.ml_loadbalancer_output["ml_alb_security_group_id"]}"
  type                     = "ingress"
  from_port                = "${var.port}"
  to_port                  = "${var.port}"
  protocol                 = "tcp"
}

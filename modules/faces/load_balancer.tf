resource "aws_lb" "faces_lb" {
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "application"
  name_prefix                = "faces-"
  security_groups            = ["${aws_security_group.faces_lb_nsg.id}"]
  subnets                    = ["${var.faces_subnet_id_1}", "${var.faces_subnet_id_2}"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-FacesLB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_listener" "port10336" {
  load_balancer_arn = "${aws_lb.faces_lb.arn}"
  port              = "10336"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port10336.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "port10337" {
  load_balancer_arn = "${aws_lb.faces_lb.arn}"
  port              = "10337"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port10337.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "port10338" {
  load_balancer_arn = "${aws_lb.faces_lb.arn}"
  port              = "10338"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port10338.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "port10336" {
  port     = "10336"
  protocol = "HTTP"
  vpc_id   = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = "10336"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port10336"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_target_group" "port10337" {
  port     = "10337"
  protocol = "HTTP"
  vpc_id   = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = "10337"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port10337"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_target_group" "port10338" {
  port     = "10338"
  protocol = "HTTP"
  vpc_id   = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = "10338"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port10338"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group" "faces_lb_nsg" {
  name_prefix = "${var.platform_instance_id}-FacesALB"
  description = "${var.platform_instance_id}-FacesALB"
  vpc_id      = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-FacesLB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

# Allow all outbound traffic
resource "aws_security_group_rule" "egress" {
  description       = "Allow all outbound"
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow Services and ECS networks
resource "aws_security_group_rule" "allow_faces" {
  description       = "allow-services-ecs"
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  type              = "ingress"
  from_port         = 10336
  to_port           = 10336
  protocol          = "tcp"
  cidr_blocks       = ["${var.services_ecs_cidrs}"]
}

resource "aws_security_group_rule" "allow_credits" {
  description       = "allow-services-ecs"
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  type              = "ingress"
  from_port         = 10337
  to_port           = 10337
  protocol          = "tcp"
  cidr_blocks       = ["${var.services_ecs_cidrs}"]
}

resource "aws_security_group_rule" "allow_slates" {
  description       = "allow-services-ecs"
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  type              = "ingress"
  from_port         = 10338
  to_port           = 10338
  protocol          = "tcp"
  cidr_blocks       = ["${var.services_ecs_cidrs}"]
}

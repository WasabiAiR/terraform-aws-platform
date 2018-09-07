resource "aws_lb" "faces_lb" {
  name_prefix                = "faces-"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.faces_lb_nsg.id}"]
  subnets                    = ["${var.faces_subnet_id_1}", "${var.faces_subnet_id_2}"]
  enable_deletion_protection = false

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-FacesNLB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_listener" "port80" {
  load_balancer_arn = "${aws_lb.faces_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port10336.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "port10336" {
  port     = "10336"
  protocol = "HTTP"
  vpc_id   = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 30
    enabled         = true
  }

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    port                = "10336"
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port10336"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group" "faces_lb_nsg" {
  name_prefix = "${var.platform_instance_id}-FacesALB"
  description = "${var.platform_instance_id}-FacesALB"
  vpc_id      = "${data.aws_subnet.subnet_faces_1.vpc_id}"

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-FacesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

# Allow all outbound traffic
resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow Services and ECS networks
resource "aws_security_group_rule" "allow_https" {
  security_group_id = "${aws_security_group.faces_lb_nsg.id}"
  description       = "allow-services-ecs"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.services_ecs_cidrs}"]
}

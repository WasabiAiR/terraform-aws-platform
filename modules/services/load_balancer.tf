resource "aws_lb" "services_alb" {
  name_prefix                = "svcs-"                                                    # name_prefix can't be longer than 6 chars
  internal                   = false
  security_groups            = ["${aws_security_group.services_alb.id}"]
  subnets                    = ["${var.public_subnet_id_1}", "${var.public_subnet_id_2}"]
  enable_deletion_protection = false

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ServicesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_listener" "port80" {
  load_balancer_arn = "${aws_lb.services_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port80.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "port443" {
  load_balancer_arn = "${aws_lb.services_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.port7000.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "port80" {
  name_prefix = "s80-"                               # name_prefix limited to 6 chars
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${data.aws_subnet.subnet_1.vpc_id}"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "301"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port80"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_target_group" "port7000" {
  name_prefix = "s7000-"                             # name_prefix limited to 6 chars
  port        = 7000
  protocol    = "HTTP"
  vpc_id      = "${data.aws_subnet.subnet_1.vpc_id}"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 30
    enabled         = true
  }

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port7000"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_listener_rule" "port80" {
  listener_arn = "${aws_lb_listener.port80.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.port80.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

resource "aws_lb_listener_rule" "port443" {
  listener_arn = "${aws_lb_listener.port443.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.port7000.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

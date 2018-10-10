resource "aws_lb" "proxy_lb" {
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "network"
  name_prefix                = "proxy-"
  subnets                    = ["${var.proxy_subnet_id_1}", "${var.proxy_subnet_id_2}"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ProxyLB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb_listener" "port3128" {
  load_balancer_arn = "${aws_lb.proxy_lb.arn}"
  port              = "3128"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.port3128.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "port3128" {
  name_prefix = "s3128-"
  port        = "3128"
  protocol    = "TCP"
  vpc_id      = "${data.aws_subnet.subnet_proxy_1.vpc_id}"

  health_check {
    healthy_threshold   = 3
    interval            = 10
    port                = "3128"
    protocol            = "TCP"
    unhealthy_threshold = 3
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-port3128"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_lb" "ml_alb" {
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "application"
  name_prefix                = "ml-"
  security_groups            = ["${aws_security_group.ml_alb.id}"]
  subnets                    = ["${var.mlservices_subnet_id_1}", "${var.mlservices_subnet_id_2}"]

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ML-ALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

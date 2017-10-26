resource "aws_elasticsearch_domain" "es" {
  domain_name           = "graymeta-${var.platform_instance_id}"
  elasticsearch_version = "5.1"
  access_policies       = "${data.template_file.policy.rendered}"

  cluster_config {
    instance_type            = "${var.instance_type}"
    instance_count           = "${var.instance_count}"
    dedicated_master_enabled = true
    dedicated_master_type    = "${var.dedicated_master_type}"
    dedicated_master_count   = "${var.dedicated_master_count}"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}


data "template_file" "policy" {
    template = "${file("${path.module}/policy.json.tpl")}"
    vars {
        account_id           = "${data.aws_caller_identity.current.account_id}"
        platform_instance_id = "${var.platform_instance_id}"
        region               = "${var.region}"
        source_ip            = "${var.source_ip}"
    }
}

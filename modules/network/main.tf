provider "aws" {
    region = "${var.region}"
}

resource "aws_vpc" "main" {
    cidr_block           = "${var.cidr_vpc}"
    enable_dns_hostnames = true

    tags {
        Name               = "GrayMetaPlatform-${var.platform_instance_id}"
        Application        = "GrayMetaPlatform"
        PlatformInstanceID = "${var.platform_instance_id}"
    }
}

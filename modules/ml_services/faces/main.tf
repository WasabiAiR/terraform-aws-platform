locals {
  api_name  = "faces"
  api_port  = "10302"
  data_port = "12302"
  tfs_port  = "11302"
}

# Generate the cloud-init script
data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    api_port          = "${local.api_port}"
    dataversion       = "1"
    data_port         = "${local.data_port}"
    log_group         = "${var.ml_loadbalancer_output["ml_cloudwatch_log_group"]}"
    postgresdb        = "faces"
    postgresendpoint  = "${element(split(":", "${aws_rds_cluster.postgresql.endpoint}"), 0)}"
    postgresrendpoint = "${element(split(":", "${aws_rds_cluster.postgresql.reader_endpoint}"), 0)}"
    postgrespass      = "${var.rds_db_password}"
    postgresport      = "5432"
    postgresuser      = "${var.rds_db_username}"
    proxy_endpoint    = "${var.ml_loadbalancer_output["proxy_endpoint"]}"
    service_name      = "${local.api_name}"
    statsite_ip       = "${var.ml_loadbalancer_output["statsite_ip"]}"
    statsite_prefix   = "${var.ml_loadbalancer_output["statsite_prefix"]}/${local.api_name}"
    tfs_port          = "${local.tfs_port}"
  }
}

# Create the cluster
module "cluster" {
  source = "../ml_cluster"

  cloud_init             = "${data.template_file.userdata.rendered}"
  instance_type          = "${var.instance_type}"
  max_cluster_size       = "${var.max_cluster_size}"
  min_cluster_size       = "${var.min_cluster_size}"
  ml_loadbalancer_output = "${var.ml_loadbalancer_output}"
  port                   = "${local.api_port}"
  service_name           = "${local.api_name}"
  services_ecs_cidrs     = "${var.services_ecs_cidrs}"
  user_init              = "${var.user_init}"
  volume_size            = "${var.volume_size}"
}

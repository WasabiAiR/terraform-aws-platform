variable "allowed_cidrs" {
  type = "list"
}

variable "dns_name" {}
variable "key_name" {}
variable "log_retention" {}
variable "platform_instance_id" {}
variable "proxy_amis" {}
variable "proxy_instance_type" {}
variable "proxy_max_cluster_size" {}
variable "proxy_min_cluster_size" {}
variable "proxy_scale_down_evaluation_periods" {}
variable "proxy_scale_down_period" {}
variable "proxy_scale_down_thres" {}
variable "proxy_scale_up_evaluation_periods" {}
variable "proxy_scale_up_period" {}
variable "proxy_scale_up_thres" {}
variable "proxy_subnet_id_1" {}
variable "proxy_subnet_id_2" {}
variable "proxy_user_init" {}
variable "proxy_volume_size" {}
variable "ssh_cidr_blocks" {}

variable "whitelist" {
  type = "list"
}

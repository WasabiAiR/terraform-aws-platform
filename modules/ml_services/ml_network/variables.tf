variable "log_retention" {
  type        = "string"
  description = "Optional. The log retention for cloudwatch logs.  Default 7 days"
  default     = "7"
}

variable "mlservices_subnet_id_1" {
  type        = "string"
  description = "The first subnet ID to use to deploy the ML services cluster(s) into. Needs to be in a different AZ than mlservices_subnet_id_2"
}

variable "mlservices_subnet_id_2" {
  type        = "string"
  description = "The second subnet ID to use to deploy the ML services cluster(s) into. Needs to be in a different AZ than mlservices_subnet_id_1"
}

variable "platform_instance_id" {
  type        = "string"
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "proxy_endpoint" {
  type        = "string"
  description = "The Proxy Load Balancer created by the network module"
}

variable "key_name" {
  type        = "string"
  description = "The name of the SSH key to use"
}

variable "ssh_cidr_blocks" {
  type        = "string"
  description = "Comma delimited list of cidr blocks from which to allow access via SSH"
}

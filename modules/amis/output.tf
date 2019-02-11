output "ecs_amis" {
  description = "map of region to ami for ecs nodes"
  value       = "${var.ecs_amis}"
}

output "mlservices_amis" {
  description = "map of region to ami for ml services nodes"
  value       = "${var.mlservices_amis}"
}

output "proxy_amis" {
  description = "map of region to ami for proxy nodes"
  value       = "${var.proxy_amis}"
}

output "services_amis" {
  description = "map of region to ami for services nodes"
  value       = "${var.services_amis}"
}

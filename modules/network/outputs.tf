output "az1_nat_ip" {
  value = "${aws_eip.nat_gateway_az1.public_ip}"
}

output "az2_nat_ip" {
  value = "${aws_eip.nat_gateway_az2.public_ip}"
}

output "ecs_cidrs" {
  value = [
    "${aws_subnet.ecs.cidr_block}",
    "${aws_subnet.ecs_2.cidr_block}",
  ]
}

output "ecs_subnet_id_1" {
  value = "${aws_subnet.ecs.id}"
}

output "ecs_subnet_id_2" {
  value = "${aws_subnet.ecs_2.id}"
}

output "elasticsearch_subnet_id_1" {
  value = "${aws_subnet.elasticsearch_1.id}"
}

output "elasticsearch_subnet_id_2" {
  value = "${aws_subnet.elasticsearch_2.id}"
}

output "mlservices_cidrs" {
  value = [
    "${aws_subnet.faces_1.cidr_block}",
    "${aws_subnet.faces_2.cidr_block}",
  ]
}

output "mlservices_subnet_id_1" {
  value = "${aws_subnet.faces_1.id}"
}

output "mlservices_subnet_id_2" {
  value = "${aws_subnet.faces_2.id}"
}

output "proxy_endpoint" {
  value = "${module.proxy.proxy_endpoint}"
}

output "proxy_subnet_id_1" {
  value = "${aws_subnet.proxy_1.id}"
}

output "proxy_subnet_id_2" {
  value = "${aws_subnet.proxy_2.id}"
}

output "public_subnet_id_1" {
  value = "${aws_subnet.public_1.id}"
}

output "public_subnet_id_2" {
  value = "${aws_subnet.public_2.id}"
}

output "rds_subnet_id_1" {
  value = "${aws_subnet.rds_1.id}"
}

output "rds_subnet_id_2" {
  value = "${aws_subnet.rds_2.id}"
}

output "services_cidrs" {
  value = [
    "${aws_subnet.services_1.cidr_block}",
    "${aws_subnet.services_2.cidr_block}",
  ]
}

output "services_subnet_id_1" {
  value = "${aws_subnet.services_1.id}"
}

output "services_subnet_id_2" {
  value = "${aws_subnet.services_2.id}"
}

output "statsite_ip" {
  value = "${module.statsite.statsite_ip}"
}

output "statsite_nsg" {
  value = "${module.statsite.statsite_nsg}"
}

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

output "services_subnet_id_1" {
    value = "${aws_subnet.services_1.id}"
}

output "services_subnet_id_2" {
    value = "${aws_subnet.services_2.id}"
}

output "ecs_subnet_id" {
    value = "${aws_subnet.ecs.id}"
}

output "elasticsearch_subnet_id_1" {
    value = "${aws_subnet.elasticsearch_1.id}"
}

output "elasticsearch_subnet_id_2" {
    value = "${aws_subnet.elasticsearch_2.id}"
}

output "ecs_nat_ip" {
    value = "${aws_eip.nat_gateway_ecs.public_ip}"
}

output "services_nat_ip" {
    value = "${aws_eip.nat_gateway_services.public_ip}"
}

output "statsite_ip" {
  value = "${aws_instance.statsite.private_ip}"
}

output "statsite_nsg" {
  value = "${aws_security_group.statsite.id}"
}

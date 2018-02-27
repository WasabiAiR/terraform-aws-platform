# Network Requirements

* Single VPC. VPC must have DNS host names enabled. Attach an internet gateway.
* Stand up 7 subnets as follows and record the subnet ID of each:
  * Public subnet 1:
    * size: /24
    * availability zone: different than Public subnet 2
    * route 0.0.0.0/0 through the Internet gateway
    * record the subnet id as variable `public_subnet_id_1`
  * Public subnet 2:
    * size: /24
    * availability zone: different than Public subnet 1
    * route 0.0.0.0/0 through the Internet gateway
    * record the subnet id as variable `public_subnet_id_2`
  * Services subnet 1:
    * size: /24
    * availability zone: different than Services subnet 2
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `services_subnet_id_1`
  * Services subnet 2:
    * size: /24
    * availability zone: different than Services subnet 1
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `services_subnet_id_2`
  * RDS subnet 1:
    * size: As small as a /29 or as large as a /24
    * availability zone: different than RDS subnet 2
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `rds_subnet_id_1`
  * RDS subnet 2:
    * size: As small as a /29 or as large as a /24
    * availability zone: different than RDS subnet 1
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `rds_subnet_id_2`
  * ECS subnet:
    * size: /21
    * availability zone: no hard requirement here, but typically deployed in the same AZ as Services subnet 1
    * route 0.0.0.0/0 through the ECS NAT gateway
    * record the subnet id as variable `ecs_subnet_id_1`
  * Elasticsearch Subnet 1:
    * size: /24 (needs to be as large as `instance_count` / 2 * 3 addresses available where `instance_count` is the number of instances not counting dedicated master nodes in the ES cluster)
    * availability zone: different than Elasticsearch Subnet 2, should be same AZ as Services Subnet 1
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `elasticsearch_subnet_id_1`
  * Elasticsearch Subnet 2:
    * size: /24 (needs to be as large as `instance_count` / 2 * 3 addresses available where `instance_count` is the number of instances not counting dedicated master nodes in the ES cluster)
    * availability zone: different than Elasticsearch Subnet 1, should be same AZ as Services Subnet 2
    * route 0.0.0.0/0 through the Services NAT gateway
    * record the subnet id as variable `elasticsearch_subnet_id_1`
* Create a NAT gateway for the Services\* subnets. Record the EIP assigned to the NAT gateway as variable `services_nat_ip`. Note that it must be in CIDR notation: `1.2.3.4/32`
* Create a NAT gateway for the ECS subnet. Record the EIP assigned to the NAT gateway as variable `ecs_nat_ip`. Note that it must be in CIDR notation: `1.2.3.4/32`


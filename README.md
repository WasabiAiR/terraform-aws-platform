# Deploying GrayMeta Platform with Terraform

* Pick a _platform instance id_ for this deployment of the GrayMeta platform. A short, descriptive name like `production`, `labs`, `test`, etc. that can be used to uniquely identify this deployment of the GrayMeta Platform within your environment. Record this as variable `platform_instance_id`
* Pick which AWS region you want to deploy into from the list below:
  * us-east-1
  * us-east-2
  * us-west-2
  * ap-southeast-2
  * eu-west-1
* Pick the hostname which will be used to access the platform (example: graymeta.example.com). Record this value as the `dns_name` variable.
* Procure a valid SSL certificate for the hostname chosen in the previous step. Self-signed certificates will NOT work. Upload the SSL certificate to Amazon Certificate Manager in the same region you will be deploying the platform into. After upload, record the ARN of the certificate as variable `ssl_certificate_arn`
* Create an S3 bucket to store thumbnails, transcoded video and audio preview files, and metadata files. Record the ARN of the s3 bucket as variable `file_storage_s3_bucket_arn`.
* Stand up a network. If you don't want to manually stand up a network the `modules/network` module can be used to stand up all of the networking components:
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
  * Create a NAT gateway for the Services\* subnets. Record the EIP assigned to the NAT gateway for use when standing up your Elasticsearch domain below.
  * Create a NAT gateway for the ECS subnet. Record the EIP assigned to the NAT gateway as variable `ecs_nat_ip`. Note that it must be in CIDR notation: `1.2.3.4/32`
* Stand up an Elasticsearch Domain running version 5.1 of Elasticsearch . The `modules/elasticsearch` module can be used if necessary. AWS recently added VPC support for their Elasticsearch offering, however it is not currently supported by a released version of the Terraform AWS provider. Until it is officially released, standing up an Elasticsearch Domain is outside the scope of the platform deployment. Make sure you set the following access policy (replace REGION, ACCOUNT_ID, DOMAIN, and SOURCE_IP with valid values - SOURCE_IP is the EIP of the Services NAT Gateway):
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:REGION:ACCOUNT_ID:domain/DOMAIN/*",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["SOURCE_IP"]}
            }
        }
    ]
}
```
* Decide the CIDR or CIDRs that will be allowed access to the platform. Record as comma delimited lists of CIDR blocks.
  * `platform_access_cidrs` - The list of CIDRs that will be allowed to access the web ports of the platform
  * `ssh_cidr_blocks` - The list of CIDRs that will be allowed SSH access to the servers. This is typically an admin or VPN subnet somewhere within your VPC.
* Fill in the rest of the variables, review the output of a `terraform plan`, then apply the changes.
* Create a CNAME from your `dns_name` to the value of the `GrayMetaPlatformEndpoint` output. This needs to be publicly resolvable.
* Load `https://dns_name` where _dns\_name_ is the name you chose above. The default username is `admin@graymeta.com`. The password is set to the instance ID of one of the Services nodes of the platform. These are tagged with the name `GrayMetaPlatform-${platform_instance_id}-Services` in the EC2 console. There should be at least 2 nodes running. Try the instance ID of both. After logging in for the first time, change the password of the `admin@graymeta.com` account. Create other accounts as necessary.

# Graymeta Faces extractor
(Optional) If you want to install and use the Graymeta Faces extractor.

## Example
  
```
module "faces" {
  source = "github.com/graymeta/terraform-aws-platform//modules/faces?ref=v0.0.32"

  platform_instance_id = "${local.platform_instance_id}"

  faces_instance_type    = "m5.2xlarge"
  faces_max_cluster_size = "2"
  faces_min_cluster_size = "1"
  faces_subnet_id_1      = "${module.network.faces_subnet_id_1}"
  faces_subnet_id_2      = "${module.network.faces_subnet_id_2}"
  faces_volume_size      = "50"
  key_name               = "${local.key_name}"
  log_retention          = "7"

  rds_allocated_storage = "100"
  rds_backup_retention  = "7"
  rds_backup_window     = "03:00-04:00"
  rds_db_instance_size  = "db.m4.xlarge"
  rds_db_password       = "mydbpassword"
  rds_db_username       = "mydbuser"
  rds_multi_az          = true
  rds_snapshot          = ""   # Set to final after the initial deployment
  rds_subnet_id_1       = "${module.network.rds_subnet_id_1}"
  rds_subnet_id_2       = "${module.network.rds_subnet_id_2}"
  
  services_ecs_cidrs = [ "${module.network.ecs_cidrs}", "${module.network.services_cidrs}" ]
  ssh_cidr_blocks    = "10.0.0.0/24,10.0.1.0/24"
}
```

# Platform update
We need to pass the faces enpoint to the platform module.  
  

```
module "platform" {
  source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.32"
  ...
  faces_endpoint = "${module.faces.faces_endpoint}"
  ...
}

# Graymeta Faces extractor
(Optional) If you want to install and use the Graymeta Faces extractor.

## Example
  
```
module "faces" {
  source = "github.com/graymeta/terraform-aws-platform//modules/faces?ref=${local.version}"

  key_name             = "${local.key_name}"
  log_retention        = "${local.log_retention}"
  platform_instance_id = "${local.platform_instance_id}"
  ssh_cidr_blocks      = "${local.ssh_cidr_blocks}"

  # Faces Cluster Configuration
  faces_instance_type    = "m5.2xlarge"
  faces_max_cluster_size = "2"
  faces_min_cluster_size = "1"
  faces_volume_size      = "50"

  # RDS Configuration
  rds_allocated_storage = "100"
  rds_backup_retention  = "7"
  rds_backup_window     = "03:00-04:00"
  rds_db_instance_size  = "db.m4.xlarge"
  rds_db_password       = "mydbpassword"
  rds_db_username       = "mydbuser"
  rds_multi_az          = true
  rds_snapshot          = ""   # Set to final after the initial deployment

  # Network Configuration
  faces_subnet_id_1  = "${module.network.faces_subnet_id_1}"
  faces_subnet_id_2  = "${module.network.faces_subnet_id_2}"
  rds_subnet_id_1    = "${module.network.rds_subnet_id_1}"
  rds_subnet_id_2    = "${module.network.rds_subnet_id_2}"
  services_ecs_cidrs = [ "${module.network.ecs_cidrs}", "${module.network.services_cidrs}" ]
}
```

# Platform update
We need to pass the faces endpoint to the platform module.  
   
```
module "platform" {
  source = "github.com/graymeta/terraform-aws-platform?ef=${local.version}"
  ...
  # (Optional) Graymeta Faces Extractor
  faces_endpoint = "${module.faces.faces_endpoint}"
  ...
}
```
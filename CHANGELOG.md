# Changelog

All notable changes to this project will be documented in this file.

---
## [NOT RELEASED] - 2018-10-26

#### Added

* (Optional) No longer required for SES to be configured in the same region as the platform.  If you have SES in another region just add the following to the platform module.  Default is the same region as the platform if left blank.
```
    module "platform" {
      ...
      notifications_region = "us-west-2"
      ...
    }
```

* (Optional). Accounts will now be locked out after numerous failed login attempts in a given timeframe. The lockouts are tuneable with the following parameters:
  * `account_lockout_attempts` - The number of failed login attempts that will trigger an account lockout. Default: 5
  * `account_lockout_interval` - The amount of time an account is locked out after exceeding the threshold for number of failed logins. Default: 10m.  Valid values must be parseable as a Golang [time.Duration](https://godoc.org/time#ParseDuration)
  * `account_lockout_period` - The window of time for failed login attempts to trigger an account lockout. Default: 10m.  Valid values must be parseable as a Golang [time.Duration](https://godoc.org/time#ParseDuration)
```
    module "platform" {
      ...
      account_lockout_attempts = "5"
      account_lockout_interval = "10m"
      account_lockout_period = "10m"
      ...
    }
```

* (Optional). Minimum password length is now a configurable option. Default is 8 characters long
```
    module "platform" {
      ...
      password_min_length = "8"
      ...
    }

```

#### Changed

* (Optional). Box.com and Dropbox support has been refactored. Please see the [OAuth storage provider README](README-oauth-storage.md) for details.
```
    module "platform" {
      ...
      box_com_client_id  = "your box.com client id"
      box_com_secret_key = "your box.com client secret"
      dropbox_app_key    = "your Dropbox application key"
      dropbox_app_secret = "your Dropbox application secret"
      ...
    }
```

---
## [v0.1.0] - 2018-10-24
**Upgrading to this release will cause an outage while the proxy cluster is created, and Services and ECS instances are recreate.**

#### Added
* Two new subnets for proxy instances in the network module.  You need to apply only if the default value for vpc_cidr was not used.
```
    module "network" {
      ...
      cidr_subnet_proxy_1 = "10.0.20.0/24"
      cidr_subnet_proxy_2 = "10.0.21.0/24"
      ...
    }
```
   
* Added a Proxy cluster in the network module.  All routes from other subnets to NAT gateway have been removed.  This will create a new internal loadbalancer with proxy instances.  All outbound api requests are now locked down by the proxy cluster.  The autoscaling thresholds should be adjusted for the instance type.
```
    module "network" {
      ...
      # Proxy Cluster
      dns_name               = "foo.cust.graymeta.com"
      key_name               = "${local.key_name}"
      log_retention          = "7"
      proxy_instance_type    = "m4.large"
      proxy_max_cluster_size = 4
      proxy_min_cluster_size = 2
      proxy_scale_down_thres = "12500000" # bytes = 100 Mb/s
      proxy_scale_up_thres   = "50000000" # bytes = 400 Mb/s
      ssh_cidr_blocks        = "10.0.0.0/24,10.0.1.0/24"
      ...
    }
```
   
* Add the Proxy endpoint variable to the platform module.
```
    module "platform" {
      ...
      proxy_endpoint = "${module.network.proxy_endpoint}"
      ...
    }
```

* (Optional) Added Credits to the Faces cluster.  To setup the extractor in the UI you need the credits endpoint.  In the UI go to Settings -> Extractors -> Credits.  Then insert the output from credits_endpoint in the Hostname field.
```
    output "credits_endpoint" {
        value = "${module.faces.credit_endpoint}"
    }
```
  
* (Optional) Added Slates to the Faces cluster.  To setup the extractor in the UI you need the slates endpoint.  In the UI go to Settings -> Extractors -> Slates.  Then insert the output from slates_endpoint in the Hostname field.
```
    output "slates_endpoint" {
        value = "${module.faces.slates_endpoint}"
    }
```
  
#### Changed
* Now creating ECS nodes in two AZ.  Network Module we renamed the `cidr_subnet_ecs` subnet to `cidr_subnet_ecs_1` and added a `cidr_subnet_ecs_2`.  Recommended that cidr_subnet_ecs_2 to be a /21 subnet.  You need to apply only if the default value for vpc_cidr was not used.
```
    module "network" {
      ...
      cidr_subnet_ecs_1 = "10.0.8.0/21"
      cidr_subnet_ecs_2 = "10.0.24.0/21"
      ...
    }
```
  
* Now creating ECS nodes in two AZ.  In the Platform module rename `ecs_subnet_id` variable to `ecs_subnet_id_1`.  Then add the `ecs_subnet_id_2` variable.
```
    module "platform" {
      ...
      ecs_subnet_id_1 = "${module.network.ecs_subnet_id_1}"
      ecs_subnet_id_2 = "${module.network.ecs_subnet_id_2}"
      ...
    }
```
  
* Renamed the ElastiCache instance so multiple platforms in the same region can be supported.

* Platform AMI update to version 2.0.2472.  Contact GrayMeta for more details

#### Removed
* Removed facebox from the platform module.  Please delete the following variables.
```
    module "platform" {
      ...
      elasticache_instance_type_facebox  = "cache.m4.large"
      facebox_key = ""
      ...
    }
```
   
---
## [v0.0.32] - 2018-09-17
#### Added
* Added variable for the RDS backup retention and window within the platform module.  The default retention is now set to 7 days and a backup window set to 03:00-04:00.  Previous versions this was not set.  This will create a pending update for the next maintenance window.
```
    module "platform" {
      source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.32"
      ...
      db_backup_retention = "7"
      db_backup_window    = "03:00-04:00"
      ...
    }
```

* Added variable to set the RDS as a multi_az.  Default is now set to true.  Previous versions this was not set.  This will create a pending update for the next maintenance window.
```
    module "platform" {
      source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.32"
      ...
      db_multi_az = true
      ...
    }
```
  
* Added two new subnets for faces in the network module.  You need to apply only if the default value for vpc_cidr was not used.
```
    module "network" {
      source = "github.com/graymeta/terraform-aws-platform//modules/network?ref=v0.0.32"
      ...
      cidr_subnet_faces_1 = "x.x.x.x/24"
      cidr_subnet_faces_2 = "x.x.x.x/24"
      ...
    }
```
  
* (Optional) Added Faces module.  More info at [README-faces](README-faces.md)
  
#### Changed
* Install 1 NAT Gateway in each AZ instead of one for Services and the other for ECS.  It is required to change the following two variable names in the platform module.  
```
    ecs_nat_ip      => az1_nat_ip
    services_nat_ip => az2_nat_ip
```
  
- Platform AMI update to version 2.0.2339.  Contact GrayMeta for more details
  
---
## [v0.0.31] - 2018-09-06  
#### Added
* (Optional) Added service and ecs cloud init settings.  These cloud-init's will be merged with GrayMeta cloud-init script.  Please check with GrayMeta support to verify your cloud-init scripts will not interfere with the defaults.
```
    module "platform" {
      source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.31"
      ...
      services_user_init = "${data.template_file.service_data.rendered}"
      ecs_user_init      = "${data.template_file.ecs_data.rendered}"
      ...
    }
```
  
#### Removed

* Consolidated Redis environment variables on the backend of the service instances.  No template changes needed.
* Removed the Box.com variables since they are now configured in the UI.  Please remove if you have the following in the platform module.

```
    # Box (Box.com)
    box_client_id                    = ""
    box_client_secret                = ""
```
  
#### Changed
* Platform AMI update to version 2.0.2312.  Contact GrayMeta for more details
  
---
## [v0.0.30] - 2018-08-10
#### Changed
- Platform AMI update to version 2.0.2258.  Contact GrayMeta for more details
  
---
## [v0.0.29] - 2018-08-03
#### Added
* Variable to define Cloudwatch retention in platform module
```
    module "platform" {
      source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.29"
      ...
      log_retention = "14"
      ...
    }
```
  
#### Changed
- Platform AMI update to version 2.0.2253.  Contact GrayMeta for more details

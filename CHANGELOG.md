# Changelog
All notable changes to this project will be documented in this file.

## [NOT_RELEASE] - <date>
#### Added
- Added Faces network to the network module


#### Changed
- Install 1 NAT Gateway in each AZ instead of one for Services and the other for ECS.  You will need to change the following two settings in the platform module.  In the Platform module you need to rename the following variables.
        ecs_nat_ip      => az1_nat_ip
        services_nat_ip => az2_nat_ip



---
## [v0.0.31] - 2018-09-06  
#### Added
- (Optional) Added service and ecs cloud init settings.  These cloud-init's will be merged with Graymeta cloud-init script.  Please check with Graymeta support to verify your cloud-init scripts will not interfere with the defaults.
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
- Consolidated Redis environment variables on the backend of the service instances.  No template changes needed.
- Removed the Box.com variables since they are now configured in the UI.  If you have the following in the platform module please remove
```
    # Box (Box.com)
    box_client_id                    = ""
    box_client_secret                = ""
```
  
#### Changed
- Platform AMI update to verision 2.0.2312.  Contact Graymeta for more details
  
---
## [v0.0.30] - 2018-08-10
#### Changed
- Platform AMI update to verision 2.0.2258.  Contact Graymeta for more details
  
---
## [v0.0.29] - 2018-08-03
#### Added
- Variable to define Cloudwatch retention in platform module
```
module "platform" {
  source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.29"
  ...
  log_retention = "14"
  ...
}
```
  
#### Changed
- Platform AMI update to verision 2.0.2253.  Contact Graymeta for more details
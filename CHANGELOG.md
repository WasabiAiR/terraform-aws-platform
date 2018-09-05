# Changelog
All notable changes to this project will be documented in this file.

---
## [v0.0.31] - 2018-09-05
#### Added
- Added service and ecs cloud init settings to be added to Graymeta default cloud init settings.  Before added check with Graymeta support to make sure it will not interfere with the default init.
```
module "platform" {
  source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.31"
  ...
  services_user_init = "${data.template_file.service_data.rendered}"
  ecs_user_init      = "${data.template_file.ecs_data.rendered}"
  ...
}
```
- Adding Dropbox location.  To the platform you will need to add Dropbox application key and Dropbox application secret.
```
module "platform" {
  source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.31"
  ...
  dropbox_app_key    = "XXXXXXXXXXXXXXX"
  dropbox_app_secret = "XXXXXXXXXXXXXXX"
  ...
}
```
  
#### Changed
- Platform AMI update to verision .  Contact Graymeta for more details
  
#### Fixed
- Consolidated Redis environment variables on the backend of the service instances.
  
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
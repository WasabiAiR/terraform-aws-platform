# Custom Cloud Init

Warning:  This will void your warranty if you create an init script that interferes with the graymeta init script.

## Prerequisites:

* data.template_file with your custom cloud init script

Services nodes will be the latest `CentOS Linux release 7`
ECS we use Amazon ECS-Optimized Image which is a `Amazon Linux`

## Procedure:

Assume you want to setup a custom cloud init script to be merged with the default cloud-init script.

###### Create data template_file  
Example
```
data "template_file" "service_data" {
  template = "${file("${path.module}/service_data.tpl")}"
}

data "template_file" "ecs_data" {
  template = "${file("${path.module}/ecs_data.tpl")}"
}
```

###### Add user_init to the platform
Example:
```
module "platform" {
    source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.25"

    ...

    services_user_init = "${data.template_file.service_data.rendered}"
    ecs_user_init      = "${data.template_file.ecs_data.rendered}"
}
```

We will use the following merge_type   `list(append)+dict(recurse_array)+str()`

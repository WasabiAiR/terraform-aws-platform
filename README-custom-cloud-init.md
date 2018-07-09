# Custom Cloud Init

## Prerequisites:

* data.template_file with your custom cloud init script


## Procedure:

Assume you want to setup a custom cloud init script to be merged with the default cloud-init script.

###### Create data template_file  
Example
```
data "template_file" "custdata" {
  template = "${file("${path.module}/custdata.tpl")}"
}
```

###### Add user_init to the platform
Example:
```
module "platform" {
    source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.25"

    ...

    user_init = "${data.template_file.custdata.rendered}"
}
```

We will use the following merge_type   `list(append)+dict(recurse_array)+str()`

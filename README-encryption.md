# Using AWS KMS to encrypt secrets in the platform.

If your security policies prevent using secrets directly in Terraform, you can use AWS KMS to encrypt configuration data. You will have to jump through additional hoops to deploy the platform.

## Multi-Stage Deployment

### Step 1: Stand up the IAM role

Your terraform configs should look like this:

```
locals {
    platform_instance_id = "labs"
    key_name             = "somekey"
}

provider "aws" {
    region = "us-east-1"
}

module "servicesiam" {
    source = "github.com/graymeta/terraform-aws-platform//modules/servicesiam?ref=v0.0.17"

    platform_instance_id = "${local.platform_instance_id}"
}
```

Peform a `terraform plan` and `terraform apply`


### Step 2: Create a KMS Customer Master Key

Log into the AWS KMS console (IAM->Encryption keys). Create a new KMS CMK or use an existing CMK. The key must exist in the same region into which you are deploying the platform. When provisioning the key or using an existinng key, add the IAM role `GrayMetaPlatform-{platform_instance_id}-Services-AssumeRole2` (where `{platform_instance_id}` is replaced by what you chose in the `locals` block) to the list of users that can use the key to encrypt and decrypt data. Record the ARN of the CMK.

### Step 3: Generate the encrypted configuration blob

Contact GrayMeta to get a copy of the `gmcrypt` utility. Ensure you have credentials set up in your `~/.aws/credentials` file that are allowed to use the KMS CMK. If you have credentials but they are not the `default` profile, set the `AWS_PROFILE` environment variable to the profile's name that contains the credentials.

Write out the configs you wish to encrypt into a single text file. The format is `key=value` pairs, one per line. Example:

```
# cat data.txt
key1=value1
key2=value2
```

Encrypt the file:

```
# gmcrypt -key-arn <arn of key> -region <region you are deploying into> data.txt
```

A base64 encoded string will be output. This string becomes the `encrypted_config_blob` variable in the next step

### Step 4: Add the rest of the configs to the terraform module

Add in the network(if using) and platform modules. Your Terraform config should now look like this:

```
locals {
    platform_instance_id = "labs"
    key_name             = "somekey"
}

provider "aws" {
    region = "us-east-1"
}

module "servicesiam" {
    source = "github.com/graymeta/terraform-aws-platform//modules/servicesiam?ref=v0.0.17"

    platform_instance_id = "${local.platform_instance_id}"
}

module "network" {
    source = "github.com/graymeta/terraform-aws-platform//modules/network?ref=v0.0.17"

    ... (see README.md for details)
}

module "platform" {
    source = "github.com/graymeta/terraform-aws-platform?ref=v0.0.17"

    encrypted_config_blob = "base64 encoded string from gmcrypt"

    ... (see README.md for details)
}
```

Then run a `terraform plan` and a `terraform apply`

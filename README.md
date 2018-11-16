# A Terraform module to generate a Jenkins Master node

This module will create a [Jenkins](https://jenkins.io/) node in the provided VPC and subnet.
Resources created:

* EC2 instance with all required software prerequisites installed
* new Security Group for ssh  and web access
* IAM profile for an instance
* [not yet] cronjob for sending custom CloudWatch metric reporting cluster health
* [not yet] [optional] Custom AMI for EC2 instance, it gives possibility to restore state of management node

## Preparations

The module requires that the AWS policy documents for permissions be created prior to executing.
Please use `kentrikos-tf-bootstrap` repo to create policies using the portal.
Please follow the steps outlined in the README deployment guide.

## Usage

### Basic use

```hcl
module "jenkins" {
  source = "git::git@github.com:kentrikos/terraform-aws-bootstrap-jenkins.git"

  name              = "transit-zone"

  vpc_id            = "vpc-12345"
  subnet_id         = "subnet-12345"

  http_proxy    = "10.10.10.1"

  ssh_allowed_cidrs  = ["10.10.10.0/24"]
  http_allowed_cidrs = ["10.10.10.0/24"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | (Required) Name of the instance | string | - | yes |
| subnet_id | (Required) The VPC Subnet ID to launch the instance in. | string | - | yes |
| vpc_id | (Required) The VPC ID to launch the instance in. | string | - | yes |
| jenkins_config_repo_url | Bitbucket repo url with Product Domain configuration | string | - | yes |
| ami_id | (Optional) The AMI ID, which provides restoration of pre-created managment node. (default is false). | string | `` | no |
| ec2_instance_type | Size of EC2 instance. | string | `t3.medium` | no |
| http_allowed_cidrs | (Optional) list of cidr ranges to allow HTTP access. | list | `<list>` | no |
| http_proxy | (Optional) HTTP proxy to use for access to internet. This is required to install packages on instances deployed in default AWS accounts. | string | `` | no |
| iam_policy_names | (Optional) List of IAM policy names to apply to the instance. | list | `<list>` | no |
| iam_policy_names_prefix | (Optional) Prefix for policy names created by portal. | string | `customer/` | no |
| jenkins_admin_password | Local jenkins Admin username. | string | `Password` | no |
| jenkins_admin_username | Local jenkins Admin username. | string | `Admin` | no |
| jenkins_job_repo_url | (Optional) Bitbucket repo url with Jenkins Jobs | string | `ssh://git@github.com:kentrikos/jenkins-bootstrap-pipelines.git` | no |
| key_name_prefix | (Optional) The key name of the Key Pair to use for remote management. | string | `jenkins_master` | no |
| name_suffix | (Optional) Instance name suffix. | string | `-jenkins-master-node` | no |
| ssh_allowed_cidrs | (Optional) list of cidr ranges to allow SSH access. | list | `<list>` | no |
| tags | (Optional) A mapping of tags to assign to the resource. A 'Name' tag will be created by default using the input from the 'name' variable. | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| jenkins_private_ip | The private IP address assigned to the instance |
| jenkins_username | The username assigned to the instance. |
| ssh_connection | The SSH connection string for remote management. |
| ssh_private_key | The SSH private key. |


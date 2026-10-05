# terraform-aws-networking-tf-course
Networking Module created during LM Academy Terraform course.

This module manages the creation of VPCs and subnets, allowing for the creation of both private and public subnets: -->

Example usage:

```
module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your_vpc"
  }
  subnet_config = {
    subnet1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-west-2a"
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-west-2b"
      public     = true
    }
  }
}
```

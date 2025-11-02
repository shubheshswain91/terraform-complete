# Terraform's Architecture and Core Workflow

### Question 1:
A company is developing a multi-cloud strategy, planning to deploy some services on AWS and others on Google Cloud Platform (GCP). They are evaluating IaC tools and comparing Terraform with AWS CloudFormation.

Why is Terraform generally a better choice for this specific company?


Terraform is platform-agnostic, using a provider-based architecture that allows it to manage resources across many different cloud and service providers within the same project.

Correct

This is the correct answer. Terraform's core strength is its plugin architecture, where providers for AWS, GCP, Azure, etc., enable it to manage a diverse, multi-cloud infrastructure from a unified configuration. AWS CloudFormation is a tool designed specifically for managing AWS resources and lacks native support for other clouds.

### Question 2:
A developer is writing a Terraform configuration to create an aws_instance. They are unsure of the exact name for the argument needed to specify the Amazon Machine Image (AMI) ID.

What is the best-practice method for finding this type of information?

Consult the official Terraform Registry, navigate to the AWS provider's documentation, find the aws_instance resource, and look at its documented list of arguments.

Correct

This is the correct answer. The Terraform Registry is the canonical source of truth for all provider and resource documentation. Using it ensures you are referencing the correct arguments, data types, and required attributes for the version you are using.

### Question 3:
A developer joins a new project and clones its Terraform repository from Git. The repository contains a main.tf file that defines an AWS VPC and a subnet. They open a terminal in the project directory and immediately run terraform plan. The command fails with an error message that includes: Could not load plugin and Please run "terraform init".

What is the direct cause of this error?


The developer has not initialized the project. The necessary AWS provider plugin, which is listed in the configuration, has not been downloaded and installed into the local .terraform directory yet.

Correct

This is the correct answer. terraform init is the first command that must be run in a new or cloned project to download the required providers. The .terraform folder containing these providers is not, by convention, stored in Git.

### Question 4:
A developer runs terraform plan and sees the following output in their terminal:



Terraform will perform the following actions:
 
  # aws_vpc.app_vpc will be created
    + resource "aws_vpc" "app_vpc" {
      + id                  = (known after apply)
      + cidr_block          = "172.16.0.0/16"
      + enable_dns_hostnames = true
      + instance_tenancy    = "default"
      # ... other attributes
    }
 
  # aws_internet_gateway.gw will be created
    + resource "aws_internet_gateway" "gw" {
      + id      = (known after apply)
      + vpc_id  = (known after apply)
      # ... other attributes
    }
 
Plan: 2 to add, 0 to change, 0 to destroy.


What is the correct interpretation of this output?


Terraform has compared the configuration with the current state and has determined that it needs to create two new resources: a VPC and an Internet Gateway. No changes will be made until terraform apply is run.

Correct

This is the correct answer. The + symbol signifies creation. The plan summary "2 to add, 0 to change, 0 to destroy" confirms that two new resources are planned. The plan command itself is a read-only operation and does not modify infrastructure.

### Question 5:
What is the primary function of the terraform destroy command?

To read the state file and delete all remote infrastructure that is currently being managed by the Terraform project.

Correct

This is the correct answer. terraform destroy is a wholesale operation used to tear down the entire infrastructure managed by the project, based on what is tracked in the state file.
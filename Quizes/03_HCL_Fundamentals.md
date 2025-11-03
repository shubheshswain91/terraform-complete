# HCL Fundamentals and State Management

### Question 1:
A developer needs to configure a cloud firewall rule that allows web traffic. The rule needs to be associated with an existing Virtual Private Cloud (VPC) that is managed by a different team and a separate Terraform project.

Consider the following HCL snippet:
data "aws_vpc" "shared_network" {
  tags = {
    Name = "corp-production-vpc"
  }
}
 
resource "aws_security_group" "web_traffic" {
  name   = "allow-web-inbound"
  vpc_id = data.aws_vpc.shared_network.id
  // ... other rules
}

What is the primary function of the data "aws_vpc" "shared_network" block?

To look up and retrieve the details (like its ID) of an existing VPC in the cloud account so that the new security group can be associated with it.

Correct

This is the correct answer. data sources are used to fetch information about infrastructure that already exists and is not managed by the current Terraform project. In this case, it finds the VPC by its tag and makes its attributes, like the ID, available for use in other resources.

### Question 2:
A developer is configuring the provider requirements for a new project and wants to ensure that only versions from the 5.x series are used, but to allow for any bugfix releases within a specific minor version. They write the following block:



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }
}


Which of the following provider versions would be considered INVALID by this version constraint?


5.41.0

Correct

This is the correct answer. The pessimistic constraint operator ~> allows only the rightmost version component to increment. For ~> 5.40.0, it will match any version >= 5.40.0 but < 5.41.0. Therefore, 5.41.0 is not allowed because the minor version component (41) is different.

### Question 3:
A team's Terraform state file is currently being stored locally on each developer's laptop. A senior engineer points out that the state file contains the IP addresses of newly created databases, access keys for service accounts, and other sensitive information.

What is the primary security risk of this local storage approach?

The state file contains sensitive data in plain text. If a developer's laptop is stolen or compromised, this data could be exposed, leading to a major security breach.

Correct

This is the correct answer. The state file is a snapshot of the infrastructure's attributes, which often includes sensitive data. Storing it unencrypted on a local machine, which could be lost or compromised, is a significant security vulnerability.

### Question 4:
A developer is trying to create two S3 buckets but receives an error when running terraform plan. The code is shown below:



resource "aws_s3_bucket" "app_storage" {
  bucket = "my-unique-app-data-202501"
}
 
resource "aws_s3_bucket" "app_storage" {
  bucket = "my-unique-app-logs-202501"
}


What is the cause of the error?

The combination of the resource type (aws_s3_bucket) and local name (app_storage) must be unique within the project. The developer has used the same local name for both resources.

Correct

This is the correct answer. In HCL, every resource block is identified by its type and its local name. This address must be unique. To fix this, the second resource's local name should be changed to something different, like app_logs.

### Question 5:
An administrator makes an emergency manual change in the AWS console, adding an inbound rule to a firewall to allow a developer to debug a production issue. The firewall was originally created and is managed by Terraform. The next morning, a standard CI/CD pipeline runs terraform apply.

What is the most likely outcome for the emergency firewall rule?

Terraform will detect a difference between the state file's record of the firewall and its actual configuration in AWS. It will then remove the manually added rule to make the live resource match the configuration code.

Correct

This is the correct answer. This scenario describes "configuration drift." Terraform uses the state file and code as the source of truth. During the refresh step, it detects that the live resource has "drifted" from the desired configuration and will generate a plan to revert the manual change.

### Question 6:
A platform engineering team wants to standardize the creation of application servers. The goal is to ensure most servers use a specific, security-hardened golden image (AMI) by default, but to also allow for approved exceptions when a different image is required for a specific application.

Which combination of HCL blocks is best suited to implement this "secure-by-default" pattern?


A variable block to receive the AMI ID with a default value set to the golden image, and a resource block that references this variable.

Correct

This is the correct answer. Using a variable with a default value is the ideal pattern. It establishes the golden image as the standard for all deployments, making it easy to do the "right thing" by default. This pattern also provides the necessary flexibility to override the default for specific, approved use cases by passing a different value for the variable.
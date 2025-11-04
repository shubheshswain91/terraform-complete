# Terraform CLI, Backends, and Provider Configuration

### Question 1:
Why is using a remote backend, such as Amazon S3, considered a critical best practice for teams working collaboratively on a Terraform project?

It provides a centralized, shared location for the state file and supports state locking, which prevents multiple team members from running conflicting apply operations simultaneously.

Correct

This is the correct answer. The default local state is specific to one machine, making collaboration impossible. A remote backend ensures everyone on the team is working with the same state. State locking is a crucial feature of most remote backends that prevents state corruption from concurrent runs.

### Question 2:
Consider the following provider configuration:



provider "aws" {
  region = "eu-west-1" // Ireland
}
 
provider "aws" {
  alias  = "virginia"
  region = "us-east-1" // N. Virginia
}
 
resource "aws_s3_bucket" "archive" {
  bucket = "corp-ireland-archive-bucket-123"
}
 
resource "aws_kms_key" "encryption_key" {
  provider = aws.virginia
  // ... other configuration
}


Based on this code, where will the two resources be created?


The aws_s3_bucket.archive will be created in the eu-west-1 region, and the aws_kms_key.encryption_key will be created in the us-east-1 region.

Correct

This is the correct answer. The S3 bucket resource does not have a provider argument, so it uses the default (unaliased) provider, which is configured for eu-west-1. The KMS key resource explicitly specifies provider = aws.virginia, so it uses the aliased provider configured for us-east-1.

### Question 3:
A developer runs terraform plan -out=tfplan and carefully reviews the output to ensure the changes are correct. Satisfied, they run terraform apply tfplan. They are surprised when the command proceeds to create resources without asking for a "yes" confirmation prompt.

What is the reason for this behavior?

When terraform apply is executed with a saved plan file as an argument, it assumes the plan has already been reviewed and approved, so it skips the interactive confirmation step by design.

Correct

This is the correct answer. This workflow is intended for automation. The plan step is for human review, and saving the plan creates an artifact. Applying that specific artifact is meant to be a non-interactive execution of the pre-approved changes.

### Question 4:
A new team member needs to start working on an existing Terraform project. They have just cloned the repository. Which sequence of commands represents the standard, correct workflow to safely preview and then apply the configuration?


terraform init, then terraform validate, then terraform plan, then terraform apply.

Correct

This is the correct answer. init downloads providers. validate performs a local syntax check. plan creates a preview of changes by checking the remote state. apply executes the planned changes after confirmation. This is the standard, safe workflow.

### Question 5:
A team wants to manage 100% of their AWS infrastructure—including their S3 bucket for the Terraform state file—using a single Terraform project. What is the fundamental "chicken and egg" problem they will face?


To initialize the project with the S3 backend, the S3 bucket must already exist. However, to create that S3 bucket with Terraform, the project must first be initialized.

Correct

This is the correct answer. This circular dependency is a classic bootstrapping problem. You cannot use Terraform with a remote backend to create the backend itself. The common solution is to create the backend resources manually or with a separate, simpler Terraform project that uses a local backend.
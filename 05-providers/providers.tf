terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east"
}

resource "aws_s3_bucket" "us_west_1" {
  bucket = "some-random-bucket-name-asdfgghhh"
}

resource "aws_s3_bucket" "us_east_2" {
  bucket   = "some-random-bucket-name-asdf123dd"
  provider = aws.us-east
}
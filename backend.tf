#Define variables for reusable values
variable "s3_bucket" {
  description = "The s3 bucket for Terraform state"
  type = string
}

variable "dynamodb_table" {
  description = "The DynamoDB table for state locking"
  type = string
}

variable "region" {
  description = "The AWS region"
  type = string
}

terraform {
  backend "s3" {
    bucket = var.s3_bucket
    key = "week7-project/terraform.tfstate"
    region = var.region
    dynamodb_table = var.dynamodb_table
    encrypt = true
  }
}

variable "s3_bucket" {
  description = "The S3 bucket for Terraform state"
  type        = string
  default     = "name_of_bucket"  # Replace with your actual bucket name
}

variable "dynamodb_table" {
  description = "The DynamoDB table for state locking"
  type        = string
  default     = "name_of_my_dynamodb_table"  # Replace with your actual DynamoDB table name
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"  # Replace with your actual AWS region
}

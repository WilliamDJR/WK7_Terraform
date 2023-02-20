variable "aws_iam_role_name" {
  type = string
}

variable "lambda_function_name" {
  type = list
}

# s3 bucket used for store lambda function
variable "s3_bucket_name" {
  type = string
}

variable "lambda_zipfile_name" {
  type = list
}

variable "lambda_description" {
  type = list
}

variable "lambda_handler" {
  type = list
}

variable "api_gateway_execution_arn" {
  type = string
}
variable "lambda_function_name" {
  type = list
}
variable "aws_iam_role_name" {
  type = string
}
variable "api_gateway_name" {
  type = string
}
variable "api_gateway_resource_name" {
  type = list
}
variable "lambda_function_layer" {
  type = map
}
# s3 bucket used for store lambda function
variable "s3_bucket_name" {
  type = string
}
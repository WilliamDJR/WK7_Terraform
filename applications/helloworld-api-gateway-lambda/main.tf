module "helloworld-apigateway" {
  source = "../../modules/api-gateway"

  api_gateway_name          = var.api_gateway_name
  api_gateway_resource_name = var.api_gateway_resource_name
}

module "helloworld-lambda" {
  source = "../../modules/lambda"

  lambda_function_name      = var.lambda_function_name
  aws_iam_role_name         = var.aws_iam_role_name
  lambda_function_layer     = var.lambda_function_layer
  s3_bucket_name            = var.s3_bucket_name
  lambda_zipfile_name
}
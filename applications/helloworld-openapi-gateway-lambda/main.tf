/********************************
	API Gateway with stages
********************************/
resource "aws_api_gateway_rest_api" "image-processor" {
  body = templatefile("api_template.yml", { lambda_uri = var.lambda_uri })

  name = "image-processor-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "image-processor" {
  rest_api_id = aws_api_gateway_rest_api.image-processor.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.image-processor.body))
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_stage" "image-processor-uat" {
  deployment_id = aws_api_gateway_deployment.image-processor.id
  rest_api_id   = aws_api_gateway_rest_api.image-processor.id
  stage_name    = "uat"
  variables = {
    lambdaAlias = "uat"
  }
  depends_on = [aws_cloudwatch_log_group.image-processor-uat-api]
}

resource "aws_api_gateway_stage" "image-processor-prod" {
  deployment_id = aws_api_gateway_deployment.image-processor.id
  rest_api_id   = aws_api_gateway_rest_api.image-processor.id
  stage_name    = "prod"
  variables = {
    lambdaAlias = "prod"
  }
  depends_on = [aws_cloudwatch_log_group.image-processor-prod-api]
}

/********************************
	Cloudwatch logs
********************************/
resource "aws_cloudwatch_log_group" "image-processor-uat-api" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.image-processor.id}/uat"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "image-processor-prod-api" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.image-processor.id}/prod"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "image-processor-lambda" {
  name              = "/aws/lambda/${var.aws_lambda_function}"
  retention_in_days = 7
}

/****************************************************************
	Lambda function with alias & layers
****************************************************************/
module "lambda-function-layer" {
  source             = "terraform-aws-modules/lambda/aws"
  create             = true
  create_layer       = true
  layer_skip_destroy = true

  layer_name          = var.aws_lambda_layer_function //"ImageProcessor-layer"
  description         = "${var.aws_lambda_function} Lambda layer (deployed from S3)"
  compatible_runtimes = ["nodejs16.x"]

  create_package = false
  s3_existing_package = {
    bucket = var.s3_layer_bucket //"jr-lambda-layer"
    key    = var.s3_layer_key    //"ImageProcessor-layer.zip"
  }
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.aws_lambda_function
  description   = "${var.aws_lambda_function} lambda function"

  s3_bucket = var.s3_bucket           //"jr-lambda-code"
  s3_key    = var.s3_key              //"ImageProcessor.zip"
  runtime   = var.lambda_runtime      //"nodejs16.x"
  handler   = var.lambda_handler      //"index.handler"
  publish   = var.publish_new_version //true for the first time

  role = var.lambda_role //"arn:aws:iam::026559016816:role/lambda-recommendation-system-iam"

  layers = [
    module.lambda-function-layer.lambda_layer_arn
  ]
  depends_on = [
    aws_cloudwatch_log_group.image-processor-lambda
  ]

}

module "alias_uat" {
  source = "terraform-aws-modules/lambda/aws//modules/alias"

  refresh_alias = true

  name = "uat"

  function_name    = var.aws_lambda_function //"Image-Processor" 
  function_version = "$LATEST"
}

module "alias_prod" {
  source = "terraform-aws-modules/lambda/aws//modules/alias"

  refresh_alias = true

  name = "prod"

  function_name    = var.aws_lambda_function //"Image-Processor" 
  function_version = var.lambda_prod_version //"1"
}

resource "aws_lambda_permission" "lambda_apigateway-uat" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${var.aws_lambda_function}:uat"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.image-processor.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "lambda_apigateway-prod" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${var.aws_lambda_function}:prod"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.image-processor.execution_arn}/*/*/*"
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_gateway_name
  description = "api gateway name"
  endpoint_configuration {
    types     = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  count       = length(var.api_gateway_resource_name)
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  path_part   = var.api_gateway_resource_name[count.index]
}

resource "aws_api_gateway_method" "api_gateway_method" {
  count       = length(var.api_gateway_resource_name)
  authorization = "NONE"
  http_method = "POST"
  resource_id = aws_api_gateway_resource.api_gateway_resource[count.index].id
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  count       = length(var.api_gateway_resource_name)
  resource_id = aws_api_gateway_resource.api_gateway_resource[count.index].id
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  http_method = aws_api_gateway_method.api_gateway_method[count.index].http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri         = aws_lambda_function.lambda_function[count.index].invoke_arn
}

resource "aws_api_gateway_method_response" "response_200" {
  count       = length(var.api_gateway_resource_name)
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource[count.index].id
  http_method = aws_api_gateway_method.api_gateway_method[count.index].http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "integration_response" {
  count       = length(var.api_gateway_resource_name)
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource[count.index].id
  http_method = aws_api_gateway_method.api_gateway_method[count.index].http_method
  status_code = aws_api_gateway_method_response.response_200[count.index].status_code

  response_templates = {
    "application/json" = ""
  }
  depends_on = [
    aws_api_gateway_integration.api_gateway_integration
  ]
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.api_gateway_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "uat"
}
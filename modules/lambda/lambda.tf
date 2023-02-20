resource "aws_lambda_function" "lambda_function" {
  count            = length(var.lambda_function_name)

  s3_bucket        = var.s3_bucket_name
  s3_key           = var.lambda_zipfile_name[count.index]
  function_name    = var.lambda_function_name[count.index]
  description      = var.lambda_description[count.index]
  handler          = var.lambda_handler[count.index]

  timeout          = "30"
  memory_size      = "1024"
  runtime          = "nodejs18.x"
  role             = aws_iam_role.exec-lambda.arn
}

resource "aws_lambda_permission" "apigw" {
  count         = length(var.lambda_function_name)
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function[count.index].function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  //source_arn    = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/*"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}

module "helloworld-apigateway" {
  source = "../../modules/api-gateway"

  api_gateway_name          = "helloworld-api"
  api_gateway_resource_name = ["helloworld.zip", "lookup.zip"]
  lambda_functions_invoke_arn = module.helloworld-lambda.lambda_functions_invoke_arn
}

module "helloworld-lambda" {
  source = "../../modules/lambda"

  lambda_function_name      = ["Helloworld", "lookup"]
  aws_iam_role_name         = "LambdaWithApiGateway"
  s3_bucket_name            = "lambdas-willido"
  lambda_zipfile_name       = ["helloworld.zip", "lookup.zip"]
  lambda_handler =  ["index.handler", "index_getname.handler"]
  lambda_description = ["helloworld lambda", "lookup only lambda"]
  api_gateway_execution_arn = module.helloworld-apigateway.api_gateway_execution_arn
  s3_resources = ["arn:aws:s3:::lambdas-willido", "arn:aws:s3:::tfstate-willido"]
}
module "another-apigateway" {
  source = "../../modules/api-gateway"

  api_gateway_name          = "another-api"
  api_gateway_resource_name = ["another"]
  lambda_functions_invoke_arn = module.another-lambda.lambda_functions_invoke_arn
}

module "another-lambda" {
  source = "../../modules/lambda"

  lambda_function_name      = ["another"]
  aws_iam_role_name         = "LambdaWithApiGateway"
  s3_bucket_name            = "lambdas-william"
  lambda_zipfile_name       = ["another.zip"] // must be loaded to your s3 bucket before run terraform apply
  lambda_handler =  ["index.handler"]
  lambda_description = ["another lambda"]
  api_gateway_execution_arn = module.another-apigateway.api_gateway_execution_arn
  s3_resources = ["arn:aws:s3:::lambdas-william", "arn:aws:s3:::tfstate-william"]
  dynamodb_table_arn = module.another-dynamodb.dynamodb_table_arn
}

module "another-dynamodb" {
  source = "../../modules/dynamodb"

  tableName = "AnotherTable" 
  attributes = ["id", "name"]
}
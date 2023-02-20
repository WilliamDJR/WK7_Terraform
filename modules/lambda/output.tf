output "lambda_functions_invoke_arn" {
    value = aws_lambda_function.lambda_function[*].function_name.invoke_arn
}
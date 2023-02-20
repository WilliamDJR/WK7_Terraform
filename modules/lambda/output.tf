output "lambda_functions" {
    value = aws_lambda_function.lambda_function[*].function_name
}
resource "aws_iam_role" "exec-lambda" {
  name               = var.aws_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    # Terraform's "jsonencode" function converts a
    # Terraform expression result to valid JSON syntax.
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.exec-lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_iam_role_policy_attachment" "S3PutObjectPolicy" {
  role       = aws_iam_role.exec-lambda.name
  policy_arn = "arn:aws:iam:::policy/S3PutObjectPolicy"
}
resource "aws_iam_role_policy_attachment" "S3GetObjectPolicy" {
  role       = aws_iam_role.exec-lambda.name
  policy_arn = "arn:aws:iam:::policy/S3GetObjectPolicy"
}
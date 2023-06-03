resource "aws_dynamodb_table" "helloworld-dynamodb-table" {
  name           = var.tableName
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = var.attributes[0]
  range_key      = var.attributes[1]

  attribute {
    name = var.attributes[0]
    type = "N"
  }

  attribute {
    name = var.attributes[1]
    type = "S"
  }
}
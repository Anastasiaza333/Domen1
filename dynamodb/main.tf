resource "aws_dynamodb_table" "this" {
    name         = var.table_name
    hash_key     = "id"
     billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}
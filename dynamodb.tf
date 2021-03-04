resource "aws_dynamodb_table" "remote_state_locking" {
  name           = var.name
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


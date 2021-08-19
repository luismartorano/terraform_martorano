#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
#Configuração necessária para subir um state locking table no DynamoDB
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name             = "terraform-state-lock-dynamo"
  hash_key         = "LockID"
  read_capacity    = 20
  write_capacity   = 20


  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }

}
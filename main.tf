#https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs?utm_content=documentLink&utm_medium=vscode&utm_source=terraform-ls

provider "aws" {
  #region  = "us-east-2"
  #usando a mudança de workstation, vc coloca workspace em 2 regioes diferentes! 
  #se for procution us-east2, se outra sa-east1
  region  = "${terraform.workspace == "production" ? "us-east-2" : "sa-east-1"}"
}


//state é armazenado dentro do s3 da Amazon.  
terraform {
  backend "s3" {
     #Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "terraform-luismartorano"
    #dynamodb_table = "terraform-state-lock-dynamo"            //state locking
    key    = "terraform-princ.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}

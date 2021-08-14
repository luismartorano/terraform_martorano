#https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs?utm_content=documentLink&utm_medium=vscode&utm_source=terraform-ls

provider "aws" {
  region  = "us-east-2"

}

terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "terraform-luismartorano"
    key    = "terraform-princ.tfstate"
    region = "us-east-2"
  }
}
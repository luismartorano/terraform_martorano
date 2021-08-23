resource "aws_default_vpc" "default" {}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-d0eb76bb" #minha vpc na amazon us-east-2 (workspace production)
  #vpc_id      = "vpc-9f11d5f9" #minha vpc na amazon sa-east-1 (workspace staging)
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port     = 0
      to_port       = 0
      protocol      = "-1"
      cidr_blocks   = ["0.0.0.0/0"] 
  }
}



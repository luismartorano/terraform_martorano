//tudo dentro da pasta servers é considerado modulo filho
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ubuntu_image_name}"]
  }

  owners = ["099720109477"] 
}


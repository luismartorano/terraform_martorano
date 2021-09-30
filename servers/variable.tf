variable "ubuntu_image_name" {
  #default = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  type        = string
  description = "The image string for searching in AWS"
}


variable "servers" {
  type    = number
  default = 1
}


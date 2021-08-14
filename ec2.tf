data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ubuntu}"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "web" {
  #count = 2
  ami           = data.aws_ami.ubuntu.id  #ami-0117d177e96a8481c ver no terraform console
  instance_type = "t2.micro"
  key_name = "ubuntu"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  
  //É bom saber pq cai na prova, mas a Hashicorp diz q não é bom usar o provisioner!
  provisioner "remote-exec" {
    inline = [
      "touch /tmp/test"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = "${self.public_ip}" #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = "${file("ubuntu.pem")}"
      
    }
  }
  tags = {
    Name = "HelloWorld"
  }
}
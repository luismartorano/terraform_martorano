resource "aws_instance" "master" {
  count         = 1                      #var.servers            #no arquivo terrafile.tf ele passa a quantidade, observar que foi definido uma variavel servers no modulo filho 
  ami           = data.aws_ami.ubuntu.id #ami-0117d177e96a8481c ver no terraform console
  instance_type = "t3.medium"
  key_name      = "chave2" #Criar a Key+pair em Network & Security, choose Key Pairs para regiam e gerar o .pem na raiz do codigo
  #chave2 no caso é para são paulo, devemos mudar o workspace STAGING
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
    encrypted   = true
  }
  provisioner "file" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = file("chave2.pem")
    }
    source      = "~/ec2/terraform_martorano/scripts/script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = file("chave2.pem")
    }
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
  tags = {
    Name = "seucool-master"
  }
}
resource "aws_instance" "nodes" {
  count         = var.servers            #no arquivo terrafile.tf ele passa a quantidade, observar que foi definido uma variavel servers no modulo filho 
  ami           = data.aws_ami.ubuntu.id #ami-0117d177e96a8481c ver no terraform console
  instance_type = "t3.medium"
  key_name      = "chave2" #Criar a Key+pair em Network & Security, choose Key Pairs para regiam e gerar o .pem na raiz do codigo
  #chave2 no caso é para são paulo, devemos mudar o workspace STAGING
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  depends_on = [
    aws_instance.master
  ]
  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
    encrypted   = true

  }
  provisioner "file" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = file("chave2.pem")
    }
    source      = "~/ec2/terraform_martorano/scripts/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = file("chave2.pem")
    }
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
  tags = {
    Name = "seulcool-node-${count.index + 1}"
  }
}

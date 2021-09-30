resource "aws_instance" "web" {
  count         = var.servers #no arquivo terrafile.tf ele passa a quantidade, observar que foi definido uma variavel servers no modulo filho 
  ami           = data.aws_ami.ubuntu.id  #ami-0117d177e96a8481c ver no terraform console
  instance_type = "t2.micro"
  key_name     = "chave2" #Criar a key_pair na regiar e setar aqui! Esta é a de OHIO! Workspace PRODUCTION
  
  #key_name = "chave2" #Criar a Key+pair em Network & Security, choose Key Pairs para regiam e gerar o .pem na raiz do codigo
  #chave2 no caso é para são paulo, devemos mudar o workspace STAGING
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  


  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the new AWS instance.
  #provisioner "file" {
  #  connection {
  #    type     = "ssh"
  #    user     = "ubuntu"
  #    host     = "${self.public_ip}" #vai pegar o ip de dentro do recurso
  #    #password = "${var.root_password}"
  #    private_key = "${file("chave2.pem")}"
  #    
  #  }
  #  source      = "./scripts"
  #  destination = "/tmp"
  #}
  
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = "${self.public_ip}" #vai pegar o ip de dentro do recurso
      #password = "${var.root_password}"
      private_key = "${file("chave2.pem")}"
      
    }
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl",
      "curl -fsSL https://get.docker.com | bash",
      #"curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",
      #"sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
      "sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose",
    ]
    
  }

  tags = {
    Name = "Terrinha"
  }

}


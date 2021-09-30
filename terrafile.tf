#input que será depois definido dentro do módulo filho, nele defino quantos servidores vou criar
module "servers" {
  source            = "./servers"
  servers           = 2
  ubuntu_image_name = var.ubuntu_image_name
}




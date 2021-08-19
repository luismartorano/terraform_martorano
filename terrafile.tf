#input que será depois definido dentro do módulo filho, nele defino quantos servidores vou criar
module "servers" {
  source = "./servers"
  servers = 1
}

//chamada para OUTPUT, pegou o valor do modulo filho que será definido no módulo raiz
// ex. ip_address = ip para o modulo raiz
output "ip_address" {
  value = module.servers.ip_address
}

/*
//recurso para DNS privado na AWS no Route53
resource "aws_route53_record" "server" {
  zone_id = 
  name    = "server"
  type    = "A"
  ttl     = "300"
  records = [module.servers.ip_address[0]] //substituir por *
}
*/
//chamada para OUTPUT, pegou o valor do modulo filho que será definido no módulo raiz
// ex. ip_address = ip para o modulo raiz
output "ip_address" {
  value = module.servers.ip_address
}

output "public_dns" {
  value = module.servers.public_dns
}
//chamada para OUTPUT, pegou o valor do modulo filho que será definido no módulo raiz
// ex. ip_address = ip para o modulo raiz
output "ip_address_master" {
  value = module.servers.ip_address_master
}

output "public_dns_master" {
  value = module.servers.public_dns_master
}

output "ip_address_nodes" {
  value = module.servers.ip_address_nodes
}

output "public_dns_nodes" {
  value = module.servers.public_dns_nodes
}

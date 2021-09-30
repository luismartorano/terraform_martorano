output "ip_address_master" {
  value = aws_instance.master.*.public_ip #mostra vários indices dos ips das maquinas criadas
}

output "public_dns_master" {
  value = aws_instance.master.*.public_dns
}

output "ip_address_nodes" {
  value = aws_instance.nodes.*.public_ip #mostra vários indices dos ips das maquinas criadas
}

output "public_dns_nodes" {
  value = aws_instance.nodes.*.public_dns
}

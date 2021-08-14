output "ip_address" {
  value = "${aws_instance.web[*].public_ip}" #mostra vários indices dos ips das maquinas criadas
}
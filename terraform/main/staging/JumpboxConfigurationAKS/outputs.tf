## Output Private key of the vm and public ip

output "private_key" {
  value     = tls_private_key.web_server.private_key_pem
  sensitive = true
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
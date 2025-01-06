# Create EC2 key pair
resource "tls_private_key" "web_server" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "web_server_key" {
  key_name   = "web-server-stg-key"
  public_key = tls_private_key.web_server.public_key_openssh
}

# Store private key in Secrets Manager
resource "aws_secretsmanager_secret" "web_server_key" {
  name = "web-server-stg-private-key"
}

resource "aws_secretsmanager_secret_version" "web_server_key" {
  secret_id     = aws_secretsmanager_secret.web_server_key.id
  secret_string = tls_private_key.web_server.private_key_pem
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.web_subnet.id
  key_name                    = aws_key_pair.web_server_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-server-stg"
  }
}
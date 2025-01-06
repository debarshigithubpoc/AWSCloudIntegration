data "aws_subnet" "web_subnet" {
  filter {
    name   = "tag:Name"
    values = ["eks-dev-vpc-001-web-pub-subnet-001"]
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for web server"
  vpc_id      = data.aws_subnet.web_subnet.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}

# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create EC2 key pair
resource "tls_private_key" "web_server" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "web_server_key" {
  key_name   = "web-server-key"
  public_key = tls_private_key.web_server.public_key_openssh
}

# Store private key in Secrets Manager
resource "aws_secretsmanager_secret" "web_server_key" {
  name = "web-server-private-key"
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
    Name = "web-server"
  }
}

## Output Private key of the vm and public ip

output "private_key" {
  value     = tls_private_key.web_server.private_key_pem
  sensitive = true
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
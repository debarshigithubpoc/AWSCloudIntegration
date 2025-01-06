# Security Group for VPC Endpoints
resource "aws_security_group" "ecr_endpoint_sg" {
  name        = "ecr-endpoint-sg"
  description = "Security group for ECR VPC endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.4.0/24", # Jump Box Subnet CIDR
      "10.0.5.0/24"  # EKS Control plane Subnet CIDR
    ]
  }

  tags = {
    Name = "eks-dev-ecr-endpoint-sg"
  }
}

# ECR API Endpoint
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-south-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.web_pub_subnet_1b.id, aws_subnet.db_prv_subnet_1b.id]
  security_group_ids  = [aws_security_group.ecr_endpoint_sg.id]
  private_dns_enabled = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "eks-dev-ecr-api-endpoint"
  }
}

# ECR Docker Endpoint
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-south-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.web_pub_subnet_1b.id, aws_subnet.db_prv_subnet_1b.id]
  security_group_ids  = [aws_security_group.ecr_endpoint_sg.id]
  private_dns_enabled = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "eks-dev-ecr-dkr-endpoint"
  }
}

# S3 Gateway Endpoint for ECR
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-south-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_rt.id]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::prod-ap-south-1-starport-layer-bucket/*",
          "arn:aws:s3:::prod-ap-south-1-starport-layer-bucket"
        ]
      }
    ]
  })

  tags = {
    Name = "eks-dev-s3-endpoint"
  }
}
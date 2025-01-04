# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-dev-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name       = "eks-dev-cluster-role"
    DeployedBy = "Debarshi From IAC team"
  }
}

# Attach required policies to cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-dev-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "eks-dev-cluster-sg"
    DeployedBy = "Debarshi From IAC team"
  }
}

# Data source for app private subnets
data "aws_subnet" "app_private_subnet_1a" {
  filter {
    name   = "tag:Name"
    values = ["eks-dev-vpc-001-app-prv-subnet-001"]
  }
}

data "aws_subnet" "app_private_subnet_1b" {
  filter {
    name   = "tag:Name"
    values = ["eks-dev-vpc-001-app-prv-subnet-003"]
  }
}

# Data source for VPC
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["eks-dev-vpc-001"]
  }
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-dev-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.27"

  vpc_config {
    subnet_ids = [
      data.aws_subnet.app_private_subnet_1a.id,
      data.aws_subnet.app_private_subnet_1b.id
    ]
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_encryption_key.arn
    }
    resources = ["secrets"]
  }

  tags = {
    Name       = "eks-dev-cluster"
    DeployedBy = "Debarshi From IAC team"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# KMS key for cluster encryption
resource "aws_kms_key" "eks_encryption_key" {
  description             = "KMS key for EKS cluster encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name       = "eks-dev-cluster-key"
    DeployedBy = "Debarshi From IAC team"
  }
}

resource "aws_kms_alias" "eks_encryption_key_alias" {
  name          = "alias/eks-dev-cluster-key"
  target_key_id = aws_kms_key.eks_encryption_key.key_id
}
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


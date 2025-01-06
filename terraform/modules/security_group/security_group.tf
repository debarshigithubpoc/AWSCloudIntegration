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
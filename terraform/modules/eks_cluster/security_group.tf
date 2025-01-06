resource "aws_security_group" "eks_cluster_sg" {
  for_each    = var.eks_clusters
  name        = try(each.value.name, "eks-dev-cluster-sg")
  description = "Security group for EKS cluster control plane"
  vpc_id      = data.aws_vpc.existing_vpc[each.key].id

  ingress {
    from_port   = try(each.value.ingress.from_port, 443)
    to_port     = try(each.value.ingress.to_port, 443)
    protocol    = try(each.value.ingress.protocol, "tcp")
    cidr_blocks = try(each.value.ingress.cidr_blocks, ["10.0.0.0/16"])
  }

  egress {
    from_port   = try(each.value.egress.from_port, 0)
    to_port     = try(each.value.egress.to_port, 0)
    protocol    = try(each.value.egress.protocol, "-1")
    cidr_blocks = try(each.value.egress.cidr_blocks, ["0.0.0.0/0"])
  }

  tags = merge(try(each.value.sg_tags, {}), { DeployedBy = "Debarshi From IAC team" })
}
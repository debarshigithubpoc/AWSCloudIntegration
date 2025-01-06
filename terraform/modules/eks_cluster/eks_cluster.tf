# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  for_each = var.eks_clusters
  name     = each.value.name
  role_arn = data.aws_iam_role.eks_cluster_role[each.key].arn
  version  = try(each.value.version, "1.27")

  vpc_config {
    subnet_ids              = local.subnet_ids_by_eks[each.key]
    security_group_ids      = [aws_security_group.eks_cluster_sg[each.key].id]
    endpoint_private_access = try(each.value.vpc_config.endpoint_private_access, true)
    endpoint_public_access  = try(each.value.vpc_config.endpoint_public_access, false)
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  encryption_config {
    provider {
      key_arn = data.aws_kms_key.by_alias[each.key].arn
    }
    resources = ["secrets"]
  }

  tags = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })

}



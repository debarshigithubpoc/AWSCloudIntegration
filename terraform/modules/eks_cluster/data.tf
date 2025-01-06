data "aws_iam_role" "eks_cluster_role" {
  for_each = var.eks_clusters
  name     = each.value.role_name
}

data "aws_kms_key" "by_alias" {
  for_each = var.eks_clusters
  key_id   = each.value.kms_key_alias
}

data "aws_vpc" "existing_vpc" {
  for_each = var.eks_clusters
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}

data "aws_subnet" "selected" {
  for_each = local.subnet_lookups

  filter {
    name   = "tag:Name"
    values = [each.value.subnet_name]
  }
  vpc_id = each.value.vpc_id
}
resource "aws_ecr_repository" "ecr_repository" {
  for_each             = var.ecr_repositories
  name                 = each.value.name
  image_tag_mutability = try(each.value.image_tag_mutability, "MUTABLE")

  image_scanning_configuration {
    scan_on_push = try(each.value.image_scanning_configuration.scan_on_push, true)
  }

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration.encryption_type == "KMS" ? [1] : []
    content {
      encryption_type = each.value.encryption_configuration.encryption_type
      kms_key         = data.aws_kms_key.by_alias[each.key].arn
    }
  }

  tags = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

data "aws_kms_key" "by_alias" {
  for_each = {
    for k, v in var.ecr_repositories : k => v
    if v.encryption_configuration.encryption_type == "KMS"
  }
  key_id = each.value.encryption_configuration.kms_key_alias
}



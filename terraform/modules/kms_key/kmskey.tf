# KMS key for cluster encryption
resource "aws_kms_key" "eks_encryption_key" {
  for_each                = var.kms_keys
  description             = each.value.description
  deletion_window_in_days = try(each.value.deletion_window_in_days, 7)
  enable_key_rotation     = try(each.value.enable_key_rotation, true)
  tags                    = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

resource "aws_kms_alias" "eks_encryption_key_alias" {
  for_each      = var.kms_keys
  name          = each.value.alias_name
  target_key_id = aws_kms_key.eks_encryption_key[each.key].key_id
}
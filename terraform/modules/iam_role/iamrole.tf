# IAM Role
resource "aws_iam_role" "role" {
  name               = var.aws_iam_role.name
  assume_role_policy = jsonencode(var.aws_iam_role.assume_role_policy)
  tags               = merge(try(var.aws_iam_role.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

# Attach required policies to cluster role
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = var.aws_iam_role_policy_attachment
  policy_arn = each.value.policy_arn
  role       = aws_iam_role.role.name
}


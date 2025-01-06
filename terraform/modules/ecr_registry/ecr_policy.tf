resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  for_each   = var.ecr_policys
  repository = aws_ecr_repository.ecr_repository[each.value.ecr_key].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPullFromEKS"
        Effect = "Allow"
        Principal = {
          AWS = data.aws_iam_role.eks_iam_role[each.key].arn
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetAuthorizationToken"
        ]
      }
    ]
  })
}

data "aws_iam_role" "eks_iam_role" {
  for_each = var.ecr_policys
  name     = each.value.eks_role_name
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "ecr_repository_lifecycle" {
  for_each   = var.ecr_policys
  repository = aws_ecr_repository.ecr_repository[each.value.ecr_key].name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

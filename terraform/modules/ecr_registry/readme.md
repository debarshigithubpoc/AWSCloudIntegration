## ECR Repository and Policy for EKS Cluster

ecr_repositories = {
  eks-dev-app = {
    name                 = "eks-dev-app-repository"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = true
    }
    encryption_configuration = {
      encryption_type = "KMS"
      kms_key_alias   = "arn:aws:kms:ap-south-1:140023400461:alias/eks-dev-cluster-key"
    }
    tags = {
      Name = "eks-dev-app-repository"
    }
  }
}

ecr_policys = {
  ecr_policy1 = {
    ecr_key       = "eks-dev-app"
    eks_role_name = "eks-dev-cluster-role"
  }
}
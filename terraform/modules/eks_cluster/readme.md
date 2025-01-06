eks_clusters = {

  eks-dev-cluster = {
    name      = "eks-dev-cluster"
    role_name = "eks-dev-cluster-role"
    vpc_name  = "eks-dev-vpc-001"
    vpc_config = {
      endpoint_private_access = true
      endpoint_public_access  = false
    }
    subnets = {

      subnet1 = {
        subnet_name = "eks-dev-vpc-001-app-prv-subnet-001"
      }
      subnet2 = {
        subnet_name = "eks-dev-vpc-001-app-prv-subnet-003"
      }

    }
    kms_key_alias = "arn:aws:kms:ap-south-1:140023400461:alias/eks-dev-cluster-key"
    tags = {
      Name = "eks-dev-cluster"
    }
    sg_tags = {
      Name = "eks-dev-cluster-sg"
    }
  }
}
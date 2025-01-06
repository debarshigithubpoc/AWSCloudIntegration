## KMS Key for EKS Cluster

kms_keys = {
  kms_key1 = {
    description = "KMS key for EKS cluster encryption"
    tags = {
      Name = "eks-dev-cluster-key"
    }
    alias_name = "alias/eks-dev-cluster-key"
  }
}
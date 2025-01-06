## Iam Roles for EKS 

iam_roles = {
  eks_role = {
    aws_iam_role = {
      name = "eks-dev-cluster-role"
      assume_role_policy = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "eks.amazonaws.com"
            }
          }
        ]
      }

      tags = {
        Name = "eks-dev-cluster-role"
      }
    }

    aws_iam_role_policy_attachment = {
      policy_attachment_1 = {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      }
      policy_attachment_2 = {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }
}

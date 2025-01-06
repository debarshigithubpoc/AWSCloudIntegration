This configuration:

Creates an ECR repository with:

Image scanning on push
KMS encryption using the same key as EKS
Mutable image tags
Attaches ECR read policy to EKS cluster role

Sets up repository policy allowing EKS to pull images

Implements lifecycle policy to manage image retention

To use ECR with your EKS cluster:

Push images to ECR:
Reference ECR images in your Kubernetes manifests:
The EKS cluster will automatically have permissions to pull images from this ECR repository.

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
docker tag app:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/eks-dev-app-repository:latest
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/eks-dev-app-repository:latest

image: <account-id>.dkr.ecr.ap-south-1.amazonaws.com/eks-dev-app-repository:latest
data "aws_subnet" "web_subnet" {
  filter {
    name   = "tag:Name"
    values = ["eks-prod-vpc-001-web-pub-subnet-001"]
  }
}

# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
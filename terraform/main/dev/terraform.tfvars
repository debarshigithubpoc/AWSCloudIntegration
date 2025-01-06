## Create VPC and Subnets for AWS EKS Cluster

vpcs = {

  vpc1 = {

    vpc = {
      cidr_block       = "10.0.0.0/16"
      instance_tenancy = "default"
      tags = {
        Name = "eks-dev-vpc-001"
      }
    }

    vpc_subnet = {

      ## EKS Jump Box Subnet
      web_pub_subnet_1a = {
        cidr = "10.0.1.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-web-pub-subnet-001"
        }
      }

      ## Application DB Subnet
      db_prv_subnet_1a = {
        cidr = "10.0.2.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-db-prv-subnet-002"
        }
      }

      ## EKS Control plane and Worker Node Subnet
      app_prv_subnet_1a = {
        cidr = "10.0.3.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-app-prv-subnet-001"
        }
      }

      ## EKS Jump Box Subnet
      web_pub_subnet_1b = {
        cidr = "10.0.4.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-dev-vpc-001-web-pub-subnet-002"
        }
      }

      ## EKS Control plane and Worker Node Subnet
      db_prv_subnet_1b = {
        cidr = "10.0.5.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-dev-vpc-001-db-prv-subnet-004"
        }
      }

      ## Application DB Subnet
      app_prv_subnet_1b = {
        cidr = "10.0.6.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-dev-vpc-001-app-prv-subnet-003"
        }
      }
    }

  }

}

## Internet Gateway

internet_gateways = {
  igw1 = {
    vpc_name = "eks-dev-vpc-001"
    tags = {
      Name = "eks-dev-vpc001-igw-001"
    }
  }
}


## Nat Gateway

nat_gateways = {
  ngw1 = {
    subnet_name = "eks-dev-vpc-001-web-pub-subnet-001"
    tags = {
      Name = "eks-dev-vpc001-natgway-001"
    }
  }
}


## Route Tables , routes and Route table assocation for AWS EKS Cluster

route_tables = {
  private_rt_1 = {
    vpc_name     = "eks-dev-vpc-001"            # VPC name tag to lookup
    gateway_name = "eks-dev-vpc001-natgway-001" # NAT gateway name tag to lookup
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "nat" # Uses NAT gateway for internet access
      },
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local" # Local route for VPC CIDR
      }
    ]
    tags = {
      Name = "eks-dev-vpc001-prvtrt-001"
    }
  }

  public_rt_1 = {
    vpc_name     = "eks-dev-vpc-001"
    gateway_name = "eks-dev-vpc001-igw-001"
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "internet" # Uses Internet Gateway
      },
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local" # Local route for VPC CIDR
      }
    ]
    tags = {
      Name = "eks-dev-vpc001-pubtrt-001"
    }
  }

  private_rt_2 = {
    vpc_name     = "eks-dev-vpc-001"            # VPC name tag to lookup
    gateway_name = "eks-dev-vpc001-natgway-001" # NAT gateway name tag to lookup
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "nat" # Uses NAT gateway for internet access
      },
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local" # Local route for VPC CIDR
      }
    ]
    tags = {
      Name = "eks-dev-vpc001-prvtrt-002"
    }
  }

  private_rt_3 = {
    vpc_name     = "eks-dev-vpc-001"            # VPC name tag to lookup
    gateway_name = "eks-dev-vpc001-natgway-001" # NAT gateway name tag to lookup
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "nat" # Uses NAT gateway for internet access
      },
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local" # Local route for VPC CIDR
      }
    ]
    tags = {
      Name = "eks-dev-vpc001-prvtrt-003"
    }
  }

  private_rt_4 = {
    vpc_name     = "eks-dev-vpc-001"            # VPC name tag to lookup
    gateway_name = "eks-dev-vpc001-natgway-001" # NAT gateway name tag to lookup
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "nat" # Uses NAT gateway for internet access
      },
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local" # Local route for VPC CIDR
      }
    ]
    tags = {
      Name = "eks-dev-vpc001-prvtrt-004"
    }
  }
}

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

## Network ACLs for EKS Cluster

nacls = {

  web_public = {
    vpc_name = "eks-dev-vpc-001"
    subnets = {

      subnet1 = {
        subnet_name = "eks-dev-vpc-001-web-pub-subnet-001"
      }
      subnet2 = {
        subnet_name = "eks-dev-vpc-001-web-pub-subnet-002"
      }
    }


    ingress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
      }
    ]
    egress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
      }
    ]
    tags = {
      Name = "eks-dev-web-public-nacl"
    }
  }

  app_private = {
    vpc_name = "eks-dev-vpc-001"
    subnets = {

      subnet1 = {
        subnet_name = "eks-dev-vpc-001-app-prv-subnet-001"
      }
      subnet2 = {
        subnet_name = "eks-dev-vpc-001-app-prv-subnet-003"
      }

    }
    ingress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "10.0.3.0/24"
        from_port  = 0
        to_port    = 0
      },
      {
        protocol   = -1
        rule_no    = 110
        action     = "allow"
        cidr_block = "10.0.6.0/24"
        from_port  = 0
        to_port    = 0
      }
    ]
    egress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "10.0.0.0/16"
        from_port  = 0
        to_port    = 0
      }
    ]
    tags = {
      Name = "eks-dev-app-private-nacl"
    }
  }

  db_private = {
    vpc_name = "eks-dev-vpc-001"
    subnets = {

      subnet1 = {
        subnet_name = "eks-dev-vpc-001-db-prv-subnet-002"
      }
      subnet2 = {
        subnet_name = "eks-dev-vpc-001-db-prv-subnet-004"
      }

    }
    ingress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "10.0.2.0/24"
        from_port  = 0
        to_port    = 0
      },
      {
        protocol   = -1
        rule_no    = 110
        action     = "allow"
        cidr_block = "10.0.5.0/24"
        from_port  = 0
        to_port    = 0
      }
    ]
    egress_rules = [
      {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "10.0.0.0/16"
        from_port  = 0
        to_port    = 0
      }
    ]
    tags = {
      Name = "eks-dev-db-private-nacl"
    }
  }

}

# route_tables = {
#   rt1 = {
#     vpc_name     = "my-vpc"
#     gateway_type = "internet"
#     gateway_name = "my-igw"
#     routes = [
#       {
#         cidr_block   = "0.0.0.0/0"
#         gateway_type = "internet"
#         gateway_id   = null
#       }
#     ]
#     tags = {
#       Environment = "prod"
#     }
#   }

#   rt2 = {
#     vpc_name     = "my-vpc-2"
#     gateway_type = "nat"
#     gateway_name = "my-nat"
#     routes = [
#       {
#         cidr_block   = "0.0.0.0/0"
#         gateway_type = "nat"
#         gateway_id   = null
#       }
#     ]
#     tags = {
#       Environment = "dev"
#     }
#   }
# }

# route_tables_association = {

#   assoc1 = {
#     subnet_name     = "subnet-1"
#     route_table_key = "rt1"
#   }

#   assoc2 = {
#     subnet_name     = "subnet-2"
#     route_table_key = "rt2"
#   }

# }

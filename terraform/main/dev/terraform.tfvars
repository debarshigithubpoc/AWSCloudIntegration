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
      web_pub_subnet_1a = {
        cidr = "10.0.1.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-web-pub-subnet-001"
        }
      }
      db_prv_subnet_1a = {
        cidr = "10.0.2.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-db-prv-subnet-002"
        }
      }
      app_prv_subnet_1a = {
        cidr = "10.0.3.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-dev-vpc-001-app-prv-subnet-001"
        }
      }
      web_pub_subnet_1b = {
        cidr = "10.0.4.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-dev-vpc-001-web-pub-subnet-002"
        }
      }
      db_prv_subnet_1b = {
        cidr = "10.0.5.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-dev-vpc-001-db-prv-subnet-004"
        }
      }
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

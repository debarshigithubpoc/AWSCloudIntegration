vpcs = {

  vpc1 = {

    vpc = {
      cidr_block       = "172.0.0.0/16"
      instance_tenancy = "default"
      tags = {
        Name = "eks-stg-vpc-001"
      }
    }

    vpc_subnet = {
      web_pub_subnet_1a = {
        cidr = "172.0.1.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-stg-vpc-001-web-pub-subnet-001"
        }
      }
      db_prv_subnet_1a = {
        cidr = "172.0.2.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-stg-vpc-001-db-prv-subnet-002"
        }
      }
      app_prv_subnet_1a = {
        cidr = "172.0.3.0/24"
        az   = "ap-south-1a"
        tags = {
          Name = "eks-stg-vpc-001-app-prv-subnet-001"
        }
      }
      web_pub_subnet_1b = {
        cidr = "172.0.4.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-stg-vpc-001-web-pub-subnet-002"
        }
      }
      db_prv_subnet_1b = {
        cidr = "172.0.5.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-stg-vpc-001-db-prv-subnet-004"
        }
      }
      app_prv_subnet_1b = {
        cidr = "172.0.6.0/24"
        az   = "ap-south-1b"
        tags = {
          Name = "eks-stg-vpc-001-app-prv-subnet-003"
        }
      }
    }

  }

}



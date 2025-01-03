vpcs = {

    vpc1 = {

        vpc = {
            cidr_block       = "192.168.0.0/16"
            instance_tenancy = "default"
                tags = {
                    Name = "eks-prod-vpc-001"
                }
        }

        vpc_subnet = {
            web_pub_subnet_1a = {
                cidr = "192.168.1.0/24"
                az   = "ap-south-1a"
                tags = {
                    Name = "eks-prod-vpc-001-web-pub-subnet-001"
                }
            }
            db_prv_subnet_1a = {
                cidr = "192.168.2.0/24"
                az   = "ap-south-1a"
                tags = {
                    Name = "eks-prod-vpc-001-db-prv-subnet-002"
                }
            }
            app_prv_subnet_1a = {
                cidr = "192.168.3.0/24"
                az   = "ap-south-1a"
                tags = {
                    Name = "eks-prod-vpc-001-app-prv-subnet-001"
                }
            }
            web_pub_subnet_1b = {
                cidr = "192.168.4.0/24"
                az   = "ap-south-1b"
                tags = {
                    Name = "eks-prod-vpc-001-web-pub-subnet-002"
                }
            }
            db_prv_subnet_1b = {
                cidr = "192.168.5.0/24"
                az   = "ap-south-1b"
                tags = {
                    Name = "eks-prod-vpc-001-db-prv-subnet-004"
                }
            }
            app_prv_subnet_1b = {
                cidr = "192.168.6.0/24"
                az   = "ap-south-1b"
                tags = {
                    Name = "eks-prod-vpc-001-app-prv-subnet-003"
                }
            }
        }

    }

}



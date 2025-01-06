nacls = {

  web_public = {
    vpc_name = "eks-dev-vpc-001"
    subnets = {
      subnet_name = ["web_pub_subnet_1a", "web_pub_subnet_1b"]
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
      subnet_name = ["app_prv_subnet_1a", "app_prv_subnet_1b"]
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
        cidr_block = "10.0.4.0/24"
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
      subnet_name = ["db_prv_subnet_1a", "db_prv_subnet_1b"]
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
      Name = "eks-dev-db-private-nacl"
    }
  }

}
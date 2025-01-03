route_tables = {
  "rt1" = {
    vpc_name     = "my-vpc"
    gateway_type = "internet"
    gateway_name = "my-igw"
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "internet"
        gateway_id   = null
      }
    ]
    tags = {
      Environment = "prod"
    }
  },
  "rt2" = {
    vpc_name     = "my-vpc-2"
    gateway_type = "nat"
    gateway_name = "my-nat"
    routes = [
      {
        cidr_block   = "0.0.0.0/0"
        gateway_type = "nat"
        gateway_id   = null
      }
    ]
    tags = {
      Environment = "dev"
    }
  }
}

route_tables_association = {
  "assoc1" = {
    subnet_name     = "subnet-1"
    route_table_key = "rt1"
  },
  "assoc2" = {
    subnet_name     = "subnet-2"
    route_table_key = "rt2"
  }
}

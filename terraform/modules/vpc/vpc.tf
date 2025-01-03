resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc.cidr_block
  instance_tenancy = try(var.vpc.instance_tenancy, "default")
  tags             = merge(try(var.vpc.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

resource "aws_subnet" "subnet" { 
    for_each            = var.vpc_subnet 
    vpc_id              = aws_vpc.vpc.id 
    cidr_block          = each.value.cidr 
    availability_zone   = each.value.az 
    tags                = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}
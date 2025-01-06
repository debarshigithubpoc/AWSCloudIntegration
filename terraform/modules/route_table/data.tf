data "aws_vpc" "existing_vpc" {
  for_each = var.route_tables
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}

data "aws_internet_gateway" "gateway" {
  for_each = {
    for k, v in var.route_tables : k => v
    if contains([for route in v.routes : route.gateway_type if lookup(route, "gateway_type", "") == "internet"], "internet")
  }
  filter {
    name   = "tag:Name"
    values = [each.value.gateway_name]
  }
}

data "aws_nat_gateway" "gateway" {
  for_each = {
    for k, v in var.route_tables : k => v
    if contains([for route in v.routes : route.gateway_type if lookup(route, "gateway_type", "") == "nat"], "nat")
  }
  filter {
    name   = "tag:Name"
    values = [each.value.gateway_name]
  }
}
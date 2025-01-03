resource "aws_route_table" "route_table" {
  for_each = var.route_tables
  vpc_id   = data.aws_vpc.existing_vpc[each.key].id
  tags     = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })

  dynamic "route" {
    for_each = try(each.value.routes, [])
    content {
      cidr_block = route.value.cidr_block
      gateway_id = lookup(
        {
          "nat"      = try(data.aws_nat_gateway.gateway[each.key].id, null),
          "internet" = try(data.aws_internet_gateway.gateway[each.key].id, null),
          "other"    = try(route.value.gateway_id, null)
        },
        route.value.gateway_type,
        route.value.gateway_id
      )
    }
  }
}

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
    if v.gateway_type == "internet"
  }
  filter {
    name   = "tag:Name"
    values = [each.value.gateway_name]
  }
}

data "aws_nat_gateway" "gateway" {
  for_each = {
    for k, v in var.route_tables : k => v
    if v.gateway_type == "nat"
  }
  filter {
    name   = "tag:Name"
    values = [each.value.gateway_name]
  }
}
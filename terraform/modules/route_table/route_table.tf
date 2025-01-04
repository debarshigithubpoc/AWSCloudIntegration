resource "aws_route_table" "route_table" {
  for_each = var.route_tables
  vpc_id   = data.aws_vpc.existing_vpc[each.key].id
  tags     = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })

  dynamic "route" {
    for_each = try(each.value.routes, [])
    content {
      cidr_block = route.value.cidr_block
      gateway_id = lookup(route.value, "gateway_id", null) != null ? route.value.gateway_id : (
        route.value.gateway_type == "internet" ? data.aws_internet_gateway.gateway[each.key].id : (
          route.value.gateway_type == "nat" ? data.aws_nat_gateway.gateway[each.key].id : null
        )
      )
    }
  }
}

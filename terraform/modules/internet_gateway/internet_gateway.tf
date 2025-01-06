resource "aws_internet_gateway" "gw" {
  for_each = var.internet_gateways
  vpc_id   = data.aws_vpc.existing_vpc[each.key].id
  tags     = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

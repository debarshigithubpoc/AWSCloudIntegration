resource "aws_eip" "nat" {
  for_each = var.nat_gateways
  vpc      = true
  tags     = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}

resource "aws_nat_gateway" "ngw" {
  for_each      = var.nat_gateways
  subnet_id     = data.aws_subnet.existing_subnet[each.key].id
  allocation_id = aws_eip.nat[each.key].id
  tags          = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}
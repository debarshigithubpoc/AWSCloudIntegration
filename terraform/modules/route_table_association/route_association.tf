resource "aws_route_table_association" "route_associations" {
  for_each       = var.route_associations
  subnet_id      = data.aws_subnet.existing[each.key].id
  route_table_id = data.aws_route_table.existing[each.key].id
}

data "aws_vpc" "existing_vpc" {
  for_each = var.route_associations
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}

data "aws_subnet" "existing" {
  for_each = var.route_associations

  filter {
    name   = "tag:Name"
    values = [each.value.subnet_name]
  }
  vpc_id = data.aws_vpc.existing_vpc[each.key].id
}

data "aws_route_table" "existing" {
  for_each = var.route_associations

  filter {
    name   = "tag:Name"
    values = [each.value.route_table_name]
  }
  vpc_id = data.aws_vpc.existing_vpc[each.key].id
}




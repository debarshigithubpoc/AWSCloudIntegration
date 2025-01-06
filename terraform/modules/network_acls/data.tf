data "aws_vpc" "existing_vpc" {
  for_each = var.nacls
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}

locals {
  # Create flattened map of subnet lookups
  subnet_lookups = merge([
    for nacl_key, nacl in var.nacls : {
      for subnet_key, subnet in nacl.subnets :
      "${nacl_key}-${subnet_key}" => {
        subnet_name = subnet.subnet_name
        vpc_id      = data.aws_vpc.existing_vpc[nacl_key].id
      }
    }
  ]...)

  # Lookup subnet IDs
  subnet_ids = {
    for k, v in local.subnet_lookups : k => data.aws_subnet.selected[k].id
  }

  # Group subnet IDs by NACL
  subnet_ids_by_nacl = {
    for nacl_key, nacl in var.nacls : nacl_key => [
      for subnet_key, subnet in nacl.subnets :
      local.subnet_ids["${nacl_key}-${subnet_key}"]
    ]
  }
}

data "aws_subnet" "selected" {
  for_each = local.subnet_lookups

  filter {
    name   = "tag:Name"
    values = [each.value.subnet_name]
  }
  vpc_id = each.value.vpc_id
}
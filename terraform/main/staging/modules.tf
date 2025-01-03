module "vpcs" {
  source     = "../../modules/vpc"
  for_each   = try(var.vpcs, {})
  vpc        = try(each.value.vpc, {})
  vpc_subnet = try(each.value.vpc_subnet, null)
}

module "route_tables" {
  source                   = "../../modules/route_table"
  route_tables             = try(var.route_tables, {})
  route_tables_association = try(var.route_tables_association, {})
  depends_on               = [module.vpcs]
}


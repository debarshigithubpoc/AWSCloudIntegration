module "vpcs" {
  source     = "../../modules/vpc"
  for_each   = try(var.vpcs, {})
  vpc        = try(each.value.vpc, {})
  vpc_subnet = try(each.value.vpc_subnet, null)
}

module "internet_gateways" {
  source            = "../../modules/internet_gateway"
  internet_gateways = try(var.internet_gateways, {})
  depends_on        = [module.vpcs]
}


module "nat_gateways" {
  source       = "../../modules/nat_gateway"
  nat_gateways = try(var.nat_gateways, {})
  depends_on   = [module.vpcs, module.internet_gateways]
}

module "route_tables" {
  source                   = "../../modules/route_table"
  route_tables             = try(var.route_tables, {})
  route_tables_association = try(var.route_tables_association, {})
  depends_on               = [module.vpcs, module.nat_gateways]
}



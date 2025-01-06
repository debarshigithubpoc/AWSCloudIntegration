module "vpcs" {
  source     = "../../modules/vpc"
  for_each   = try(var.vpcs, {})
  vpc        = try(each.value.vpc, {})
  vpc_subnet = try(each.value.vpc_subnet, null)
}

module "network_acls" {
  source     = "../../modules/network_acls"
  nacls      = try(var.nacls, {})
  depends_on = [module.vpcs]
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
  source       = "../../modules/route_table"
  route_tables = try(var.route_tables, {})
  # route_tables_association = try(var.route_tables_association, {})
  depends_on = [module.vpcs, module.nat_gateways]
}

module "iam_role" {
  source                         = "../../modules/iam_role"
  for_each                       = try(var.iam_roles, {})
  aws_iam_role                   = try(each.value.aws_iam_role, {})
  aws_iam_role_policy_attachment = try(each.value.aws_iam_role_policy_attachment, {})
}

module "kms_key" {
  source   = "../../modules/kms_key"
  kms_keys = try(var.kms_keys, {})
}

module "ecr_registry" {
  source           = "../../modules/ecr_registry"
  ecr_policys      = try(var.ecr_policys, {})
  ecr_repositories = try(var.ecr_repositories, {})
  depends_on       = [module.iam_role, module.kms_key]
}


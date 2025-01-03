module "vcn" {
  source             = "../../modules/vpc"
  for_each           = try(var.vpcs,{})
  vpc                = try(each.value.vpc, {})
  vpc_subnet         = try(each.value.vpc_subnet, null)
}

locals {
  # Create flattened map of subnet lookups
  subnet_lookups = merge([
    for eks_key, eks in var.eks_clusters : {
      for subnet_key, subnet in eks.subnets :
      "${eks_key}-${subnet_key}" => {
        subnet_name = subnet.subnet_name
        vpc_id      = data.aws_vpc.existing_vpc[eks_key].id
      }
    }
  ]...)

  # Lookup subnet IDs
  subnet_ids = {
    for k, v in local.subnet_lookups : k => data.aws_subnet.selected[k].id
  }

  # Group subnet IDs by eks
  subnet_ids_by_eks = {
    for eks_key, eks in var.eks_clusters : eks_key => [
      for subnet_key, subnet in eks.subnets :
      local.subnet_ids["${eks_key}-${subnet_key}"]
    ]
  }
}
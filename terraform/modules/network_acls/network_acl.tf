resource "aws_network_acl" "this" {
  for_each   = var.nacls
  vpc_id     = data.aws_vpc.existing_vpc[each.key].id
  subnet_ids = local.subnet_ids_by_nacl[each.key]

  dynamic "ingress" {
    for_each = try(each.value.ingress_rules, [])
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = try(each.value.egress_rules, [])
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = merge(try(each.value.tags, {}), { DeployedBy = "Debarshi From IAC team" })
}
data "aws_vpc" "existing_vpc" {
  for_each = var.internet_gateways
  filter {
    name   = "tag:Name"
    values = [each.value.vpc_name]
  }
}
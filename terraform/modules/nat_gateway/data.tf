data "aws_subnet" "existing_subnet" {
  for_each = var.nat_gateways
  filter {
    name   = "tag:Name"
    values = [each.value.subnet_name]
  }
}
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "network_acl" {
  source = "../../" # Path to the NACL module

  vpcs = {
    "default" = {
      subnet_ids = try(var.vpcs["default"].subnet_ids, data.aws_subnets.default.ids) # Fallback to default subnets
      ingress    = try(var.vpcs["default"].ingress, [])                              # Default to empty list if not provided
      egress     = try(var.vpcs["default"].egress, [])                               # Default to empty list if not provided
    }
  }

  tags = var.tags
}

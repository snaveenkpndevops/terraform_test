resource "aws_network_acl" "network_acl" {
  for_each =  var.vpcs # Iterate over each VPC in the provided map

  vpc_id     = each.key              # Assign the NACL to the corresponding VPC
  subnet_ids = each.value.subnet_ids # Associate the NACL with the specified subnets

  # Dynamic block to create ingress rules (incoming traffic)
  dynamic "ingress" {
    for_each = each.value.ingress # Iterate over the ingress rules for this VPC
    content {
      action          = lookup(ingress.value, "action", null)          # Allow/Deny traffic
      cidr_block      = lookup(ingress.value, "cidr_block", null)      # IPv4 CIDR range for the rule
      from_port       = lookup(ingress.value, "from_port", null)       # Start of the port range
      icmp_code       = lookup(ingress.value, "icmp_code", null)       # ICMP code (if applicable)
      icmp_type       = lookup(ingress.value, "icmp_type", null)       # ICMP type (if applicable)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null) # IPv6 CIDR range for the rule
      protocol        = lookup(ingress.value, "protocol", null)        # Protocol (TCP, UDP, ICMP, etc.)
      rule_no         = lookup(ingress.value, "rule_no", null)         # Rule number (determines order of evaluation)
      to_port         = lookup(ingress.value, "to_port", null)         # End of the port range
    }
  }

  # Dynamic block to create egress rules (outgoing traffic)
  dynamic "egress" {
    for_each = each.value.egress # Iterate over the egress rules for this VPC
    content {
      action          = lookup(egress.value, "action", null)          # Allow/Deny traffic
      cidr_block      = lookup(egress.value, "cidr_block", null)      # IPv4 CIDR range for the rule
      from_port       = lookup(egress.value, "from_port", null)       # Start of the port range
      icmp_code       = lookup(egress.value, "icmp_code", null)       # ICMP code (if applicable)
      icmp_type       = lookup(egress.value, "icmp_type", null)       # ICMP type (if applicable)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null) # IPv6 CIDR range for the rule
      protocol        = lookup(egress.value, "protocol", null)        # Protocol (TCP, UDP, ICMP, etc.)
      rule_no         = lookup(egress.value, "rule_no", null)         # Rule number (determines order of evaluation)
      to_port         = lookup(egress.value, "to_port", null)         # End of the port range
    }
  }

  # Assign tags to the NACL, merging default tags with custom ones
  tags = merge(
    {
      Environment = var.environment # Define the deployment environment (e.g., dev, prod)
      Owner       = var.owner       # Identify the team responsible for the resource
      Project     = var.project     # Project name for tracking
    },
    var.tags # Merge additional custom tags provided as input
  )
}

output "network_acl_ids" {
  description = "List of Network ACL IDs created for each VPC"
  value       = { for k, v in aws_network_acl.network_acl : k => v.id } # Output NACL IDs mapped to VPCs
}

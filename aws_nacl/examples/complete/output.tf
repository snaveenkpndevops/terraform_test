output "network_acl_ids" {
  description = "List of Network ACL IDs created for each VPC"
  value       = module.network_acl.network_acl_ids
}

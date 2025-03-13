module "nacl" {
  source      = "../../" # Adjust the path based on your module structure
  environment = var.environment
  owner       = var.owner
  project     = var.project
  vpcs        = var.vpcs
  tags        = var.tags
}

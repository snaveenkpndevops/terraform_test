# Define a variable for VPC configurations (NACL rules, subnets)
variable "vpcs" {
  type = map(object({
    subnet_ids = list(string)      # List of subnet IDs in each VPC
    ingress    = list(map(string)) # List of ingress rules (incoming traffic)
    egress     = list(map(string)) # List of egress rules (outgoing traffic)
  }))
  description = "Map of VPC IDs with subnet IDs and NACL rules"
}

# Define a variable for resource tags (used for identification)
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {} # Default to an empty map if no tags are provided
}

# Define the project name (helps in identifying the deployment)
variable "project" {
  description = "Name of the project"
  type        = string
  default     = null # Allows omission without requiring a default value
}

# Define the environment (helps in differentiating between prod, dev, etc.)
variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = null # Allows omission without requiring a default value
}

# Define the owner (useful for tracking who owns the resource)
variable "owner" {
  description = "The owner or team responsible for these resources"
  type        = string
  default     = null # Allows omission without requiring a default value
}

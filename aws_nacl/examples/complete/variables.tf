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



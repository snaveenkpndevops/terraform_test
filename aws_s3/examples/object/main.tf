provider "aws" {
  region = local.region

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  default_tags {
    tags = {
      Example = "object"
    }
  }
}

locals {
  region = "eu-west-1"
}

##################
# Extra resources
##################
resource "random_pet" "this" {
  length = 2
}

#############
# S3 buckets
#############
module "s3_bucket" {
  source = "../../"

  bucket        = random_pet.this.id
  force_destroy = true
}

module "s3_bucket_with_object_lock" {
  source = "../../"

  bucket        = "${random_pet.this.id}-with-object-lock"
  force_destroy = true

  object_lock_enabled = true
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = "GOVERNANCE"
        days = 1
      }
    }
  }
}

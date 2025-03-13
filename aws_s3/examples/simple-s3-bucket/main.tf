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


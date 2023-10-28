provider "aws" {
  region = "us-west-2"
}

variable "event_themes" {
  default = ["adventure-tech", "nature-escape", "data-summit"]
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  count = length(var.event_themes)

  bucket = "${var.event_themes[count.index]}-oo-bucket"

  # # Set access control settings directly within the block
  # acl = "private"

  # Disable public access block
  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
}

output "bucket_names" {
  value = module.s3-bucket[*]
}

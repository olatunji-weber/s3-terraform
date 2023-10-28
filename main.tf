provider "aws" {
  region = "us-west-2"
}

variable "event_themes" {
  default = ["AdventureTech", "NatureEscape", "DataSummit"]
}

resource "aws_s3_bucket_acl" "event_buckets" {
  count = length(var.event_themes)

  bucket = "${var.event_themes[count.index]}-OO-bucket"

  # Set access control settings directly within the block
  acl = "private"
}

output "bucket_names" {
  value = aws_s3_bucket_acl.event_buckets[*].bucket
}

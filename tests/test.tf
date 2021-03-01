provider "aws" {
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "b" {
  bucket = "ct-my-tf-test-bucket"
  acl    = "private"
}


module "firehose_enabled" {
  source = "../"

  enable = true

  name        = "firehose_enabled"
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  destination = "s3"

  s3_configuration = {
    bucket_arn      = aws_s3_bucket.b.arn
    prefix          = "prefix/"
    buffer_interval = 300
    buffer_size     = 5
  }
}

output "firehose_enabled" {
  value = module.firehose_enabled.arn
}

module "firehose_disabled" {
  source = "../"

  enable = false

  name        = "firehose_disabled"
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  destination = "s3"

  s3_configuration = {
    bucket_arn      = aws_s3_bucket.b.arn
    prefix          = "prefix/"
    buffer_interval = 300
    buffer_size     = 5
  }
}

output "firehose_disabled" {
  value = module.firehose_disabled.arn
}

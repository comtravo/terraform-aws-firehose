provider "aws" {
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  access_key                  = "This is not an actual access key."
  secret_key                  = "This is not an actual secret key."

  endpoints {
    apigateway     = "http://localstack:4566"
    cloudformation = "http://localstack:4566"
    cloudwatch     = "http://localstack:4566"
    dynamodb       = "http://localstack:4566"
    es             = "http://localstack:4566"
    firehose       = "http://localstack:4566"
    iam            = "http://localstack:4566"
    kinesis        = "http://localstack:4566"
    lambda         = "http://localstack:4566"
    route53        = "http://localstack:4566"
    redshift       = "http://localstack:4566"
    s3             = "http://localstack:4566"
    secretsmanager = "http://localstack:4566"
    ses            = "http://localstack:4566"
    sns            = "http://localstack:4566"
    sqs            = "http://localstack:4566"
    ssm            = "http://localstack:4566"
    stepfunctions  = "http://localstack:4566"
    sts            = "http://localstack:4566"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
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

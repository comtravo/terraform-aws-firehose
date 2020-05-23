# Terraform AWS module for AWS Kinesis Firehose

## Introduction

This module create a Kinesis Firehose and all the resources related to it to log to S3.

## Usage

```hcl
module "my_firehose" {
  source = "github.com/comtravo/terraform-aws-firehose"

  enable = 1

  name        = "test-firehose"
  destination = "s3"

  s3_configuration {
    bucket_arn      = "my_s3_bucket_arn"
    buffer_interval = 60
    prefix          = "some-prefix/"
  }

  account_id = "0123456789012"
}
```
## Authors

Module managed by [Comtravo](https://github.com/comtravo).

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | AWS account ID | `string` | n/a | yes |
| name | Name of the firehose | `string` | n/a | yes |
| s3\_configuration | AWS S3 configuration | <pre>object({<br>    bucket_arn      = string,<br>    buffer_interval = number,<br>    buffer_size     = number,<br>    prefix          = string<br>  })</pre> | n/a | yes |
| destination | Kinesis Firehose Destination | `string` | `"s3"` | no |
| enable | Enable firehose | `bool` | `true` | no |
| region | AWS region | `string` | `"eu-west-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the Kinesis Firehose |


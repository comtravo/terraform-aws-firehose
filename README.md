

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | AWS account ID | string | n/a | yes |
| name | Name of the firehose | string | n/a | yes |
| destination | Kinesis Firehose Destination | string | `"s3"` | no |
| enable | Enable firehose | string | `"1"` | no |
| region | AWS region | string | `"eu-west-1"` | no |
| s3\_configuration | AWS S3 configuration | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the Kinesis Firehose |


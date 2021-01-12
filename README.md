## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key\_public\_material | n/a | `any` | n/a | yes |
| subnet\_ids | n/a | `any` | n/a | yes |
| tags | n/a | `any` | n/a | yes |
| target\_group\_arn | n/a | `any` | n/a | yes |
| ami\_filter | The filter used to select the ECS AMI. amzn2-ami-ecs-hvm-2.0.????????-x86\_64-ebs is the default pattern | `list(map(string))` | <pre>[<br>  {<br>    "name": "name",<br>    "values": "amzn2-ami-ecs-hvm-2.0.????????-x86_64-ebs"<br>  }<br>]</pre> | no |
| ami\_latest | Indicator to use the latest avaiable in the the list of the AMI's for the ECS cluster. | `bool` | `true` | no |
| ami\_owners | A list of owners used to select the AMI for the ECS cluster. | `list(string)` | <pre>[<br>  "amazon"<br>]</pre> | no |
| associate\_public\_ip\_address | Associate public ip address when subnet id is attached to an internet gateway | `bool` | `false` | no |
| ecs\_optimized\_type | Type of ECS image to use | `string` | `"amzn2"` | no |
| iam\_instance\_profile | Instance profile for EC2 | `string` | `""` | no |
| image\_id | Image id | `string` | `""` | no |
| instance\_type | EC2 instance type | `string` | `"t3.micro"` | no |
| key\_name | EC2 key pair name | `string` | `""` | no |
| max\_size | n/a | `number` | `1` | no |
| min\_size | n/a | `number` | `1` | no |
| name | Common name for resources | `string` | `""` | no |
| security\_group\_id | Security group id | `string` | `""` | no |
| sg\_id | Security group id | `string` | `""` | no |
| user\_data | User data for instances | `string` | `""` | no |

## Outputs

No output.

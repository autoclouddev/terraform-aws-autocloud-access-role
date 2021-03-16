AutoCloud AWS Access Role Module
================================

### Overview

This module provisions an AWS IAM Role granting cross account read-only access rights for [AutoCloud](https://autocloud.dev)'s services to ingest your infrastructure.

Refer to the "my account" section of the application or contact your account represetative to obtain the AutoCloud organization ID for your account.

#### Assets created:

* aws_iam_role - The AWS IAM cross-account role
* aws_iam_role_policy_attachment - Several AWS IAM policy role attachments linking the cross-account role to the specific permissions allotted

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autocloud_organization_id | AutoCloud organization ID | `string` | n/a | yes |
| additional_policy_arns | ARNs for any additional IAM policies to attach to the role | `list(string)` | `[]` | no |
| description | Description for the IAM role | `string` | `"AutoCloud cross-account access role"` | no |
| enabled | Whether or not to create the IAM role | `bool` | `true` | no |
| force_detach_policies | Specifies to force detaching any policies the role has before destroying it | `bool` | `false` | no |
| iam_role_name | Name of the IAM role | `string` | `"AutoCloudReadOnly"` | no |
| include_read_only | Whether or not to add the AWS predefined ReadOnly policy to the IAM role | `bool` | `true` | no |
| include_security_audit | Whether or not to add the AWS predefined SecurityAudit policy to the IAM role | `bool` | `true` | no |
| max_session_duration | The maximum session duration (in seconds) that you want to set for the role | `number` | `3600` | no |
| path | Path of the IAM role | `string` | `"/"` | no |
| permissions_boundary | The ARN of the policy that is used to set the permissions boundary for the role | `string` | `""` | no |
| tags | Key-value map of tags for the IAM role | `map(string)` | `{}` | no |

#### Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role |
| create_date | The creation date of the IAM role |
| description | The description of the role |
| external_id | External ID for the role |
| id | The name of the role |
| name | The name of the role |
| policy_arns | A list of ARNs for the policies attached to the role |
| unique_id | The stable and unique string identifying the role |

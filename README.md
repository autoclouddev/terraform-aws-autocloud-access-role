<!-- BEGIN_TF_DOCS -->
AutoCloud AWS Access Role Module
================================

### Overview

This module provisions an AWS IAM Role granting cross account read-only access rights for [AutoCloud](https://autocloud.dev)'s services to ingest your infrastructure.

Refer to the "my account" section of the application or contact your account represetative to obtain the AutoCloud organization ID for your account.

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12.6 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a |

#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.autocloud_access_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.autocloud_access_role_policy_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.autocloud_access_role_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autocloud_organization_id"></a> [autocloud_organization_id](#input_autocloud_organization_id) | AutoCloud organization ID | `string` | n/a | yes |
| <a name="input_additional_policy_arns"></a> [additional_policy_arns](#input_additional_policy_arns) | ARNs for any additional IAM policies to attach to the role | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input_description) | Description for the IAM role | `string` | `"AutoCloud cross-account access role"` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | Whether or not to create the IAM role | `bool` | `true` | no |
| <a name="input_force_detach_policies"></a> [force_detach_policies](#input_force_detach_policies) | Specifies to force detaching any policies the role has before destroying it | `bool` | `false` | no |
| <a name="input_iam_role_name"></a> [iam_role_name](#input_iam_role_name) | Name of the IAM role | `string` | `"AutoCloudReadOnly"` | no |
| <a name="input_max_session_duration"></a> [max_session_duration](#input_max_session_duration) | The maximum session duration (in seconds) that you want to set for the role | `number` | `3600` | no |
| <a name="input_path"></a> [path](#input_path) | Path of the IAM role | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions_boundary](#input_permissions_boundary) | The ARN of the policy that is used to set the permissions boundary for the role | `string` | `""` | no |
| <a name="input_policy_name_capitalize"></a> [policy_name_capitalize](#input_policy_name_capitalize) | Whether or not to capitalize policy name components when generating IAM policy names, defaults to true, capitlize | `bool` | `true` | no |
| <a name="input_policy_name_delimiter"></a> [policy_name_delimiter](#input_policy_name_delimiter) | Delimiter used when generating the IAM policy names, defaults to null string, no delimiter | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Key-value map of tags for the IAM role | `map(string)` | `{}` | no |
| <a name="input_trusted_accounts"></a> [trusted_accounts](#input_trusted_accounts) | A list of the AWS account numbers that are allowed to assume this role, defaults to AutoCloud's SaaS accounts | `list(string)` | `[]` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_create_date"></a> [create_date](#output_create_date) | The creation date of the IAM role |
| <a name="output_description"></a> [description](#output_description) | The description of the role |
| <a name="output_external_id"></a> [external_id](#output_external_id) | External ID for the role |
| <a name="output_id"></a> [id](#output_id) | The name of the role |
| <a name="output_name"></a> [name](#output_name) | The name of the role |
| <a name="output_policy_arns"></a> [policy_arns](#output_policy_arns) | A list of ARNs for the policies attached to the role |
| <a name="output_unique_id"></a> [unique_id](#output_unique_id) | The stable and unique string identifying the role |
<!-- END_TF_DOCS -->
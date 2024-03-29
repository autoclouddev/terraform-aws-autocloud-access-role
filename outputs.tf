output "arn" {
  description = "The Amazon Resource Name (ARN) specifying the role"
  value       = join("", aws_iam_role.autocloud_access_role[*].arn)
}

output "create_date" {
  description = "The creation date of the IAM role"
  value       = join("", aws_iam_role.autocloud_access_role[*].create_date)
}

output "description" {
  description = "The description of the role"
  value       = join("", aws_iam_role.autocloud_access_role[*].description)
}

output "external_id" {
  description = "External ID for the role"
  value       = local.external_id
  sensitive   = true
}

output "id" {
  description = "The name of the role"
  value       = join("", aws_iam_role.autocloud_access_role[*].id)
}

output "name" {
  description = "The name of the role"
  value       = join("", aws_iam_role.autocloud_access_role[*].name)
}

output "policy_arns" {
  description = "A list of ARNs for the policies attached to the role"
  value       = [for policy in aws_iam_policy.autocloud_access_role_policies : policy.arn]
}

output "unique_id" {
  description = "The stable and unique string identifying the role"
  value       = join("", aws_iam_role.autocloud_access_role[*].unique_id)
}

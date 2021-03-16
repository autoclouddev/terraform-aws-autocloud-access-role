locals {
  ###
  # AutoCloud AWS Account IDs
  # 
  # AWS Accounts where AutoCloud tooling runs, and where cross-account access will originate from
  autocloud_accounts = [
    "204762158545",
    "824781544411"
  ]

  ###
  # External ID
  # 
  # Define the external ID that AutoCloud will use to access your AWS account
  external_id = "autocloud-link-${var.autocloud_organization_id}"

  ###
  # IAM Policies
  # 
  # Select the IAM policies this cross-account role will have
  iam_policies = concat(
    # Include AWS predefined ReadOnly policy?

    var.include_read_only == true ? ["arn:aws:iam::aws:policy/ReadOnlyAccess"] : [],

    # Include AWS predefined SecurityAudit policy?
    var.include_security_audit == true ? ["arn:aws:iam::aws:policy/SecurityAudit"] : [],

    # Add additional user-specified IAM policy ARNs to attach to this role
    var.additional_policy_arns
  )
}

###
# IAM Role Trust Policy
# 
# Allow AutoCloud accounts to assume this IAM role with the correct external ID
data "aws_iam_policy_document" "autocloud_access_role_assume_policy" {
  count = var.enabled == true ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = local.autocloud_accounts
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        local.external_id
      ]
    }
  }
}

###
# IAM Role
# 
# IAM role granting AutoCloud cross-account access to your AWS account with the permissions
# granted above
resource "aws_iam_role" "autocloud_access_role" {
  count = var.enabled == true ? 1 : 0

  name = var.iam_role_name
  path = var.path

  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.autocloud_access_role_assume_policy[0].json
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary != "" ? var.permissions_boundary : null

  tags = var.tags
}

###
# IAM Policy Attachments
# 
# Attach all given the policies with the IAM role
resource "aws_iam_role_policy_attachment" "autocloud_access_role_policy_attachments" {
  for_each = var.enabled == true ? toset(local.iam_policies) : []

  role       = aws_iam_role.autocloud_access_role[0].name
  policy_arn = each.value
}

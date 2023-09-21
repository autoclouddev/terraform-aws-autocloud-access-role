locals {
  ###
  # AutoCloud AWS Account IDs
  # 
  # AWS Accounts where AutoCloud tooling runs, and where cross-account access will originate from by default
  autocloud_accounts = [
    "824781544411"
  ]

  ###
  # Trusted AWS Account IDs
  #
  # AWS Accounts where cross-account access will originate, either the set of accounts if provided or AutoCloud's SaaS accounts by defatul
  trusted_accounts = length(var.trusted_accounts) > 0 ? var.trusted_accounts : local.autocloud_accounts

  ###
  # External ID
  # 
  # Define the external ID that AutoCloud will use to access your AWS account
  external_id = "autocloud-link-${var.autocloud_organization_id}"

  ###
  # IAM Policies
  # 
  # Select the IAM policies this cross-account role will have
  #
  # To avoid apply time constraints, the files listed here must be manually reconciled with contents of templates directory
  iam_policies = [
    "templates/iam/policy_1.json",
    "templates/iam/policy_2.json",
    "templates/iam/policy_3.json",
    "templates/iam/policy_4.json",
    "templates/iam/policy_5.json"
  ]

  iam_policy_arns = var.enabled != true ? [] : concat(aws_iam_policy.autocloud_access_role_policies[*].arn, var.additional_policy_arns)
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
      identifiers = local.trusted_accounts
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
# IAM Policies
#
# Create IAM policy documents from policy templates
resource "aws_iam_policy" "autocloud_access_role_policies" {
  count = var.enabled != true ? 0 : length(local.iam_policies)

  name = join(
    var.policy_name_delimiter,
    concat(
      [aws_iam_role.autocloud_access_role[0].name],
      [
        for element in split("_", split(".", basename(local.iam_policies[count.index]))[0]) :
        var.policy_name_capitalize ? title(element) : element
      ]
    )
  )

  ###
  # AutoCloud explicitly needs access to all resources to properly inventory and analyze them.
  # For this reason, the policies created use wildcard permissions.
  #
  # tfsec:ignore:aws-iam-no-policy-wildcards
  policy = file(join("/", [path.module, local.iam_policies[count.index]]))

  description = format("Policy for %s", aws_iam_role.autocloud_access_role[0].name)

  tags = var.tags

  # IAM objects take time to propagate. This leads to subtle eventual consistency bugs where dependent resources cannot be
  # provisioned because the IAM object does not exist. We add a 30 second wait here to give the IAM object a chance to
  # propagate within AWS.
  provisioner "local-exec" {
    command = "echo 'Sleeping for 30 seconds to wait for IAM object to be created'; sleep 30"
  }
}

###
# IAM Policy Attachments
# 
# Attach all given the policies with the IAM role
resource "aws_iam_role_policy_attachment" "autocloud_access_role_policy_attachments" {
  count = var.enabled != true ? 0 : length(local.iam_policy_arns)

  role       = aws_iam_role.autocloud_access_role[0].name
  policy_arn = local.iam_policy_arns[count.index]
}

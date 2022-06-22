variable "additional_policy_arns" {
  type        = list(string)
  default     = []
  description = "ARNs for any additional IAM policies to attach to the role"
}

variable "autocloud_organization_id" {
  type        = string
  description = "AutoCloud organization ID"
}

variable "description" {
  type        = string
  default     = "AutoCloud cross-account access role"
  description = "Description for the IAM role"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether or not to create the IAM role"
}

variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "Specifies to force detaching any policies the role has before destroying it"
}

variable "iam_role_name" {
  type        = string
  default     = "AutoCloudReadOnly"
  description = "Name of the IAM role"
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) that you want to set for the role"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path of the IAM role"
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "The ARN of the policy that is used to set the permissions boundary for the role"
}

variable "policy_name_capitalize" {
  type        = bool
  default     = true
  description = "Whether or not to capitalize policy name components when generating IAM policy names, defaults to true, capitlize"
}

variable "policy_name_delimiter" {
  type        = string
  default     = ""
  description = "Delimiter used when generating the IAM policy names, defaults to null string, no delimiter"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key-value map of tags for the IAM role"
}

variable "trusted_accounts" {
  type        = list(string)
  default     = []
  description = "A list of the AWS account numbers that are allowed to assume this role, defaults to AutoCloud's SaaS accounts"
}

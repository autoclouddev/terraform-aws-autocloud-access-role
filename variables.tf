variable "autocloud_organization_id" {
  type        = string
  description = "AutoCloud organization ID"
  sensitive   = true
}

variable "include_read_only" {
  type        = bool
  default     = true
  description = "Whether or not to add the AWS predefined ReadOnly policy to the IAM role"
}

variable "include_security_audit" {
  type        = bool
  default     = true
  description = "Whether or not to add the AWS predefined SecurityAudit policy to the IAM role"
}

variable "additional_policy_arns" {
  type        = list(string)
  default     = []
  description = "ARNs for any additional IAM policies to attach to the role"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether or not to create the IAM role"
}

variable "iam_role_name" {
  type        = string
  default     = "AutoCloudReadOnly"
  description = "Name of the IAM role"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path of the IAM role"
}

variable "description" {
  type        = string
  default     = "AutoCloud cross-account access role"
  description = "Description for the IAM role"
}

variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "Specifies to force detaching any policies the role has before destroying it"
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) that you want to set for the role"
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "The ARN of the policy that is used to set the permissions boundary for the role"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key-value map of tags for the IAM role"
}

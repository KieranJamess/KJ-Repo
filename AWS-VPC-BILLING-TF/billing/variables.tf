variable "currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  default     = "GBP"
}
variable "monthly_billing_threshold" {
  description = "Cap of billing in currency selected"
  default     = "5"
}

variable "sns_subscription_email_address_list" {
  type        = string
  default     = "kieran.james@infinity.co"
  description = "List of email addresses"
}

variable "sns_subscription_protocol" {
  type        = string
  default     = "email"
  description = "SNS subscription protocal"
}

variable "sns_topic_name" {
  default     = "billing-alarm-notification"
  type        = string
  description = "SNS topic name"
}

variable "sns_topic_display_name" {
  default     = "billing-alarm-notification-email"
  type        = string
  description = "SNS topic display name"
}

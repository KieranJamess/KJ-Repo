resource "aws_budgets_budget" "overall-budget-100-actual" {
  name              = "budget-monthly-100-actual"
  budget_type       = "COST"
  limit_amount      = "100"
  limit_unit        = "USD"
  time_period_start = "2020-01-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["kieranjames16@"]
  }
}

resource "aws_budgets_budget" "overall-budget-350-forecasted" {
  name              = "budget-monthly-350-forecasted"
  budget_type       = "COST"
  limit_amount      = "350"
  limit_unit        = "USD"
  time_period_start = "2020-01-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["kieranjames16@"]
  }
}

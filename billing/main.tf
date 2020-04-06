resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "billing-alarm-${lower(var.currency)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  threshold           = var.monthly_billing_threshold

  dimensions = {
    Currency = "${var.currency}"
  }
}

data "template_file" "aws_cf_sns_stack" {
  template = file("${path.module}/templates/cf_aws_sns_email_stack.json.tpl")
  vars = {
    sns_topic_name   = var.sns_topic_name
    sns_display_name = var.sns_topic_display_name
    sns_subscription_list = join(",", formatlist("{\"Endpoint\": \"%s\",\"Protocol\": \"%s\"}",
      var.sns_subscription_email_address_list,
    var.sns_subscription_protocol))
  }
}

resource "aws_cloudformation_stack" "tf_sns_topic" {
  name          = "snsStack"
  template_body = data.template_file.aws_cf_sns_stack.rendered
  tags = {
    name = "snsStack"
  }
}

# Create an SNS topic
resource "aws_sns_topic" "POC_USECASE2_SNS" {
  name = var.POC_USECASE2_SNS_NAME
#   display_name = "My SNS Topic"  # Optional display name

  # Optionally, you can add tags to the SNS topic
  tags = var.common_tags
}
# Subscribe an email address to the SNS topic
resource "aws_sns_topic_subscription" "POC_USECASE2_SNS_SUBSCRIPTION" {
  topic_arn = aws_sns_topic.POC_USECASE2_SNS.arn
  protocol  = var.POC_USECASE2_SNS_SUBSCRIPTION_PROTOCOL
  endpoint  = var.POC_USECASE2_SNS_SUBSCRIPTION_ENDPOINT # Replace with your email address
}
resource "aws_iam_policy_attachment" "POC_USECASE2_POLICY_ATTACH" {
  name = var.policy_attachment
  roles = [var.role_name]
  policy_arn = var.policy_arn
}

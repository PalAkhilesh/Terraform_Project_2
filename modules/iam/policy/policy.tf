resource "aws_iam_policy" "POC_USECASE2_POLICY" {
  name = var.policy_name
  description = var.policy_description
  policy = file("${path.module}/policies/policy.json")
}

module "policy" {
source = "../../../modules/iam/policy"
policy_name = var.policy_name
policy_description = var.policy_description
}

module "role" {
  source      = "../../../modules/iam/role"
  role_name   = var.role_name
  assume_role = data.aws_iam_policy_document.HTC_POC_OP_618579_ASSUME_ROLE.json
}

module "attach_policy" {
  source            = "../../../modules/iam/attach_policy"
  policy_attachment = var.policy_attachment
  policy_arn        = module.policy.policy_arn
  role_name         = module.role.role_name

}

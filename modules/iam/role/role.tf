resource "aws_iam_role" "POC_USECASE2_LAMBDA_ROLE" {
  name = var.role_name
  assume_role_policy = var.assume_role
  
}

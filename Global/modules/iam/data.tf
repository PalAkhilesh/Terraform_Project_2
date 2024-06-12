data "aws_iam_policy_document" "POC_USECASE2_ASSUME_ROLE" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com","glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

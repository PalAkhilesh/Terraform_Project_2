#Lambda Function Archive Creation
data "archive_file" "POC_USECASE2_LambdaFunction_CRUD_Archive" {
  type        = "zip"
  source_file = var.POC_USECASE2_LambdaFunction_FileName
  output_path = "${path.module}/${var.POC_USECASE2_LambdaFunction}"
}


# Create a Lambda function
resource "aws_lambda_function" "POC_USECASE2_Lambda" {
  filename   = data.archive_file.POC_USECASE2_LambdaFunction_CRUD_Archive.output_path
  function_name = var.POC_USECASE2_LambdaFunctionName
  handler          = var.POC_USECASE2_LambdaFunction_Handler
  runtime          = var.POC_USECASE2_LambdaFunction_Runtime
  layers        = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python312:3"]
#   source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  role = var.iam_role_arn 
  timeout         = 30

 environment {
    variables = {
     GLUE_JOB_NAME = var.POC_USECASE2_GlueJob_Name
    }
  }
  tags = var.common_tags
}
# resource "aws_lambda_event_source_mapping" "s3_trigger" {
#   event_source_arn = var.POC_USECASE2_BUCKET_arn
#   function_name    = aws_lambda_function.POC_USECASE2_Lambda.function_name
#   enabled          = true
#   batch_size       = 10
# }
# resource "aws_lambda_permission" "s3_trigger_permission" {
#   statement_id  = "AllowS3Invoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.POC_USECASE2_Lambda.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn = var.POC_USECASE2_BUCKET_arn
# }
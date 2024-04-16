##############################################
# S3-Bucket Creation
##############################################

resource "aws_s3_bucket" "HTC_POC_USECASE2_618579_BUCKET" {
  bucket = var.HTC_POC_USECASE2_618579_BUCKET_NAME

  tags = var.common_tags
}
resource "aws_s3_object" "data_folder" {
  bucket = aws_s3_bucket.HTC_POC_USECASE2_618579_BUCKET.bucket
  key    = var.HTC_POC_USECASE2_618579_BUCKET_KEY_FOLDER  # Create 'data' folder inside the bucket
 acl    = "private"  # Set ACL as per your requirements
}
resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.HTC_POC_USECASE2_618579_BUCKET.bucket
  key    = var.HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script  # Specify the key under which the script will be stored in S3
  source = "${path.module}/data-file/glue_script.py"  # Specify the local path to your Glue script
}

# s3 trigger permission for lambda
resource "aws_lambda_permission" "s3_trigger_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = var.HTC_POC_USECASE2_618579_Lambda_Name
  principal     = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.HTC_POC_USECASE2_618579_BUCKET.arn
}

# trigger mapping lambda 
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.HTC_POC_USECASE2_618579_BUCKET.id
  lambda_function {
    lambda_function_arn = var.HTC_POC_USECASE2_618579_Lambda_invoke_arn
    events             = ["s3:ObjectCreated:*"]
    filter_prefix      = "row_data/"
  }
}

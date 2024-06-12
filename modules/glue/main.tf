# Glue JOb creation

resource "aws_glue_job" "example_job" {
  name          = var.POC_USECASE2_GlueJob_Name
  description   = var.POC_USECASE2_GlueJob_Description
  role_arn      = var.iam_role_arn 
  
   command {
    name            = var.POC_USECASE2_GlueJob_Command_Name
    script_location = "s3://${var.POC_USECASE2_BUCKET}/${var.POC_USECASE2_BUCKET_FOLDER_Glue_Script}"
  }
   default_arguments = {
    "--job-language"  = var.POC_USECASE2_GlueJob_Script_Runtime 
    "--S3_BUCKET_NAME" = var.POC_USECASE2_BUCKET_NAME
    "--SNS_TOPIC_ARN" = var.POC_USECASE2_SNS_arn
    "--PUBLIC_IP" = var.public_ip

    
  }

   execution_property {
    max_concurrent_runs = 1
  }

  timeout = 60
  glue_version = "4.0"
}


# Glue JOb creation

resource "aws_glue_job" "example_job" {
  name          = var.HTC_POC_USECASE2_618579_GlueJob_Name
  description   = var.HTC_POC_USECASE2_618579_GlueJob_Description
  role_arn      = var.iam_role_arn 
  
   command {
    name            = var.HTC_POC_USECASE2_618579_GlueJob_Command_Name
    script_location = "s3://${var.HTC_POC_USECASE2_618579_BUCKET}/${var.HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script}"
  }
   default_arguments = {
    "--job-language"  = var.HTC_POC_USECASE2_618579_GlueJob_Script_Runtime 
    "--S3_BUCKET_NAME" = var.HTC_POC_USECASE2_618579_BUCKET_NAME
    "--SNS_TOPIC_ARN" = var.HTC_POC_USECASE2_618579_SNS_arn
    "--PUBLIC_IP" = var.public_ip

    
  }

   execution_property {
    max_concurrent_runs = 1
  }

  timeout = 60
  glue_version = "4.0"
}


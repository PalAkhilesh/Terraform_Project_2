#################################################
# S3-Bucket
#################################################
module "aws_s3_bucket_us_east_1" {
    source = "./modules/s3-bucket"
    providers = {
      aws =aws.us-east-1
    }
  POC_USECASE2_BUCKET_NAME=var.POC_USECASE2_BUCKET_NAME
  POC_USECASE2_BUCKET_KEY_FOLDER=var.POC_USECASE2_BUCKET_KEY_FOLDER
  common_tags = var.common_tags 
  CSV_FILE_PATH = var.CSV_FILE_PATH
  POC_USECASE2_Lambda = module.lambda_us-east-1.POC_USECASE2_Lambda_invoke_arn
  POC_USECASE2_Lambda_invoke_arn=module.lambda_us-east-1.POC_USECASE2_Lambda_invoke_arn
  POC_USECASE2_LambdaArn_Coded =var.POC_USECASE2_LambdaArn_Coded
  POC_USECASE2_Lambda_Name = module.lambda_us-east-1.POC_USECASE2_Lambda_Name
  POC_USECASE2_BUCKET_FOLDER_Glue_Script = var.POC_USECASE2_BUCKET_FOLDER_Glue_Script

}
######################################################
#SNS
######################################################
module "aws_sns_topic_us_east_1" {
    source = "./modules/sns"
    providers = {
      aws= aws.us-east-1
    }
    POC_USECASE2_SNS_NAME = var.POC_USECASE2_SNS_NAME
    POC_USECASE2_SNS_SUBSCRIPTION_ENDPOINT =var.POC_USECASE2_SNS_SUBSCRIPTION_ENDPOINT
    POC_USECASE2_SNS_SUBSCRIPTION_PROTOCOL=var.POC_USECASE2_SNS_SUBSCRIPTION_PROTOCOL
     common_tags = var.common_tags 
     POC_USECASE2_SNS_arn = module.aws_sns_topic_us_east_1.POC_USECASE2_SNS_arn
     
  
}
#################################################
#IAM
#################################################
module "iam" {
  providers = {
aws = aws.us-east-1

  }

  source             = "./Global/modules/iam"

  policy_description = var.policy_description

  policy_attachment  = var.policy_attachment

  policy_name        = var.policy_name

  role_name          = var.role_name
}
##################################################
#Lambda
##################################################
module "lambda_us-east-1" {
    source = "./modules/lambda"
    providers = {
    aws = aws.us-east-1
  }
POC_USECASE2_LambdaFunction=var.POC_USECASE2_LambdaFunction
 POC_USECASE2_LambdaFunction_FileName= var.POC_USECASE2_LambdaFunction_FileName
POC_USECASE2_LambdaFunctionName =var.POC_USECASE2_LambdaFunctionName
POC_USECASE2_LambdaFunction_Handler =var.POC_USECASE2_LambdaFunction_Handler
POC_USECASE2_LambdaFunction_Runtime = var.POC_USECASE2_LambdaFunction_Runtime
iam_role_arn = module.iam.iam_role_arn
POC_USECASE2_BUCKET_NAME = var.POC_USECASE2_BUCKET_NAME
POC_USECASE2_SNS_SUBSCRIPTION = module.aws_sns_topic_us_east_1.POC_USECASE2_SNS_arn
common_tags = var.common_tags
POC_USECASE2_SNS_arn = module.aws_sns_topic_us_east_1.POC_USECASE2_SNS_arn
POC_USECASE2_BUCKET_arn = module.aws_s3_bucket_us_east_1.POC_USECASE2_BUCKET_arn
POC_USECASE2_GlueJob_Name = var.POC_USECASE2_GlueJob_Name
}
#################################################
#Ec2 Instance
#################################################
module "ec2_us-east-1" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-1
  }
 POC_USECASE2_vpc_security_group_ids =var.POC_USECASE2_vpc_security_group_ids
 POC_USECASE2_INSTANCE_AMI_ID = var.POC_USECASE2_INSTANCE_AMI_ID
 POC_USECASE2_key_name = var.POC_USECASE2_key_name
 POC_USECASE2_EC2_INSTANCE_TYPE = var.POC_USECASE2_EC2_INSTANCE_TYPE
 common_tags = var.common_tags

  
}
################################################
#Glue
################################################
module "glue_us-east-1" {
  source = "./modules/glue"
  providers = {
    aws =aws.us-east-1
  }
  iam_role_arn = module.iam.iam_role_arn
  POC_USECASE2_GlueJob_Name = var.POC_USECASE2_GlueJob_Name
  POC_USECASE2_GlueJob_Command_Name = var.POC_USECASE2_GlueJob_Command_Name
  POC_USECASE2_BUCKET_FOLDER_Glue_Script = var.POC_USECASE2_BUCKET_FOLDER_Glue_Script
  POC_USECASE2_GlueJob_Description = var.POC_USECASE2_GlueJob_Description
  POC_USECASE2_GlueJob_Script_Runtime = var.POC_USECASE2_GlueJob_Script_Runtime
  POC_USECASE2_SNS_arn = module.aws_sns_topic_us_east_1.POC_USECASE2_SNS_arn
 POC_USECASE2_BUCKET_NAME = var.POC_USECASE2_BUCKET_NAME
 POC_USECASE2_BUCKET = var.POC_USECASE2_BUCKET_NAME
 public_ip = module.ec2_us-east-1.public_ip
}
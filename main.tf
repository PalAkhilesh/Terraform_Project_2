#################################################
# S3-Bucket
#################################################
module "aws_s3_bucket_us_east_1" {
    source = "./modules/s3-bucket"
    providers = {
      aws =aws.us-east-1
    }
  HTC_POC_USECASE2_618579_BUCKET_NAME=var.HTC_POC_USECASE2_618579_BUCKET_NAME
  HTC_POC_USECASE2_618579_BUCKET_KEY_FOLDER=var.HTC_POC_USECASE2_618579_BUCKET_KEY_FOLDER
  common_tags = var.common_tags 
  CSV_FILE_PATH = var.CSV_FILE_PATH
  HTC_POC_USECASE2_618579_Lambda = module.lambda_us-east-1.HTC_POC_USECASE2_618579_Lambda_invoke_arn
  HTC_POC_USECASE2_618579_Lambda_invoke_arn=module.lambda_us-east-1.HTC_POC_USECASE2_618579_Lambda_invoke_arn
  HTC_POC_USECASE2_618579_LambdaArn_Coded =var.HTC_POC_USECASE2_618579_LambdaArn_Coded
  HTC_POC_USECASE2_618579_Lambda_Name = module.lambda_us-east-1.HTC_POC_USECASE2_618579_Lambda_Name
  HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script = var.HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script

}
######################################################
#SNS
######################################################
module "aws_sns_topic_us_east_1" {
    source = "./modules/sns"
    providers = {
      aws= aws.us-east-1
    }
    HTC_POC_USECASE2_618579_SNS_NAME = var.HTC_POC_USECASE2_618579_SNS_NAME
    HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_ENDPOINT =var.HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_ENDPOINT
    HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_PROTOCOL=var.HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_PROTOCOL
     common_tags = var.common_tags 
     HTC_POC_USECASE2_618579_SNS_arn = module.aws_sns_topic_us_east_1.HTC_POC_USECASE2_618579_SNS_arn
     
  
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
HTC_POC_USECASE2_618579_LambdaFunction=var.HTC_POC_USECASE2_618579_LambdaFunction
 HTC_POC_USECASE2_618579_LambdaFunction_FileName= var.HTC_POC_USECASE2_618579_LambdaFunction_FileName
HTC_POC_USECASE2_618579_LambdaFunctionName =var.HTC_POC_USECASE2_618579_LambdaFunctionName
HTC_POC_USECASE2_618579_LambdaFunction_Handler =var.HTC_POC_USECASE2_618579_LambdaFunction_Handler
HTC_POC_USECASE2_618579_LambdaFunction_Runtime = var.HTC_POC_USECASE2_618579_LambdaFunction_Runtime
iam_role_arn = module.iam.iam_role_arn
HTC_POC_USECASE2_618579_BUCKET_NAME = var.HTC_POC_USECASE2_618579_BUCKET_NAME
HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION = module.aws_sns_topic_us_east_1.HTC_POC_USECASE2_618579_SNS_arn
common_tags = var.common_tags
HTC_POC_USECASE2_618579_SNS_arn = module.aws_sns_topic_us_east_1.HTC_POC_USECASE2_618579_SNS_arn
HTC_POC_USECASE2_618579_BUCKET_arn = module.aws_s3_bucket_us_east_1.HTC_POC_USECASE2_618579_BUCKET_arn
HTC_POC_USECASE2_618579_GlueJob_Name = var.HTC_POC_USECASE2_618579_GlueJob_Name
}
#################################################
#Ec2 Instance
#################################################
module "ec2_us-east-1" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-1
  }
 HTC_POC_OP_618579_vpc_security_group_ids =var.HTC_POC_OP_618579_vpc_security_group_ids
 HTC_POC_618579_USECASE2_2_INSTANCE_AMI_ID = var.HTC_POC_618579_USECASE2_2_INSTANCE_AMI_ID
 HTC_POC_OP_618579_key_name = var.HTC_POC_OP_618579_key_name
 HTC_POC_618579_USECASE2_2_EC2_INSTANCE_TYPE = var.HTC_POC_618579_USECASE2_2_EC2_INSTANCE_TYPE
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
  HTC_POC_USECASE2_618579_GlueJob_Name = var.HTC_POC_USECASE2_618579_GlueJob_Name
  HTC_POC_USECASE2_618579_GlueJob_Command_Name = var.HTC_POC_USECASE2_618579_GlueJob_Command_Name
  HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script = var.HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script
  HTC_POC_USECASE2_618579_GlueJob_Description = var.HTC_POC_USECASE2_618579_GlueJob_Description
  HTC_POC_USECASE2_618579_GlueJob_Script_Runtime = var.HTC_POC_USECASE2_618579_GlueJob_Script_Runtime
  HTC_POC_USECASE2_618579_SNS_arn = module.aws_sns_topic_us_east_1.HTC_POC_USECASE2_618579_SNS_arn
 HTC_POC_USECASE2_618579_BUCKET_NAME = var.HTC_POC_USECASE2_618579_BUCKET_NAME
 HTC_POC_USECASE2_618579_BUCKET = var.HTC_POC_USECASE2_618579_BUCKET_NAME
 public_ip = module.ec2_us-east-1.public_ip
}
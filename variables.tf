##################################################
#Provider
##################################################
variable "access_key" {}
variable "secret_key" {}
variable "aws_account" {}

##################################################
#Common-tags
##################################################
variable "common_tags" {}

##################################################
#S3-bucket creation
##################################################
variable "HTC_POC_USECASE2_618579_BUCKET_NAME" {}
variable "HTC_POC_USECASE2_618579_BUCKET_KEY_FOLDER" {}
variable "CSV_FILE_PATH" {}
variable "HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script" {}

####################################################
#SNS
####################################################
variable "HTC_POC_USECASE2_618579_SNS_NAME" {}
variable "HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_ENDPOINT" {}
variable "HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_PROTOCOL" {}


####################################################
#IAM
####################################################
variable "policy_name" {}
variable "policy_description" {}
variable "role_name" {}
variable "policy_attachment" {}

#####################################################
#Lambda
#####################################################
variable "HTC_POC_USECASE2_618579_LambdaFunction" {}
variable "HTC_POC_USECASE2_618579_LambdaFunction_archives" {}
variable "HTC_POC_USECASE2_618579_LambdaFunction_FileName" {}
variable "HTC_POC_USECASE2_618579_LambdaFunctionName" {}
variable "HTC_POC_USECASE2_618579_LambdaFunction_Handler" {}
variable "HTC_POC_USECASE2_618579_LambdaFunction_Runtime" {}
variable "HTC_POC_USECASE2_618579_LambdaArn_Coded" {}


##########################################################
#GLUE-JOB
#########################################################
variable "HTC_POC_USECASE2_618579_GlueJob_Name" {}
variable "HTC_POC_USECASE2_618579_GlueJob_Description" {}
variable "HTC_POC_USECASE2_618579_GlueJob_Command_Name" {}
variable "HTC_POC_USECASE2_618579_GlueJob_Script_Runtime" {}
variable "HTC_POC_USECASE2_618579_GlueJob_Script_Name" {}


##########################################################
#Ec2
##########################################################
variable "HTC_POC_618579_USECASE2_2_INSTANCE_AMI_ID" {}
variable "HTC_POC_618579_USECASE2_2_EC2_INSTANCE_TYPE" {}
variable "HTC_POC_OP_618579_vpc_security_group_ids" {}
variable "HTC_POC_OP_618579_key_name" {}

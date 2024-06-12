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
variable "POC_USECASE2_BUCKET_NAME" {}
variable "POC_USECASE2_BUCKET_KEY_FOLDER" {}
variable "CSV_FILE_PATH" {}
variable "POC_USECASE2_BUCKET_FOLDER_Glue_Script" {}

####################################################
#SNS
####################################################
variable "POC_USECASE2_SNS_NAME" {}
variable "POC_USECASE2_SNS_SUBSCRIPTION_ENDPOINT" {}
variable "POC_USECASE2_SNS_SUBSCRIPTION_PROTOCOL" {}


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
variable "POC_USECASE2_LambdaFunction" {}
variable "POC_USECASE2_LambdaFunction_archives" {}
variable "POC_USECASE2_LambdaFunction_FileName" {}
variable "POC_USECASE2_LambdaFunctionName" {}
variable "POC_USECASE2_LambdaFunction_Handler" {}
variable "POC_USECASE2_LambdaFunction_Runtime" {}
variable "POC_USECASE2_LambdaArn_Coded" {}


##########################################################
#GLUE-JOB
#########################################################
variable "POC_USECASE2_GlueJob_Name" {}
variable "POC_USECASE2_GlueJob_Description" {}
variable "POC_USECASE2_GlueJob_Command_Name" {}
variable "POC_USECASE2_GlueJob_Script_Runtime" {}
variable "POC_USECASE2_GlueJob_Script_Name" {}


##########################################################
#Ec2
##########################################################
variable "POC_USECASE2_INSTANCE_AMI_ID" {}
variable "POC_USECASE2_EC2_INSTANCE_TYPE" {}
variable "POC_USECASE2_vpc_security_group_ids" {}
variable "POC_USECASE2_key_name" {}

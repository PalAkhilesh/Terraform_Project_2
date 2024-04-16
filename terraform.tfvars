#######################################
#Provider
#######################################
# access_key = provide your aws access_key
# secret_key = provide your secret_key
# aws_account =  provide your aws_account

#########################################
#Common-tags
#########################################
common_tags = {
  Name    = "HTC_POC_USECASE2_618579"
  Project = "USECASE_2"
  Owner   = "Akhilesh"
  Creation_Date = "06-03-2024"
  Expiration_Date = "06=03-2024"
}

##########################################
#S3-Bucket
##########################################
HTC_POC_USECASE2_618579_BUCKET_NAME="htc-poc-618579-bucket"
HTC_POC_USECASE2_618579_BUCKET_KEY_FOLDER = "row_data/"
CSV_FILE_PATH="./modules/data-file/customer.csv"
HTC_POC_USECASE2_618579_BUCKET_FOLDER_Glue_Script = "glue-script/glue_script.py"

###########################################
#SNS
###########################################
HTC_POC_USECASE2_618579_SNS_NAME = "HTC_POC_USECASE2_618579_TOPIC"
HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_ENDPOINT = "palakhilesh803@gmail.com"
HTC_POC_USECASE2_618579_SNS_SUBSCRIPTION_PROTOCOL = "email"

###########################################
#EC2
###########################################
HTC_POC_618579_USECASE2_2_INSTANCE_AMI_ID = "ami-0c7217cdde317cfec"
HTC_POC_618579_USECASE2_2_EC2_INSTANCE_TYPE = "t2.micro"
HTC_POC_OP_618579_vpc_security_group_ids = "sg-0bba45c045a7c6d5b"   # personal account
HTC_POC_OP_618579_key_name  = "awsUSECASE22_618579_key_pair"

################################################################################################
# IAM TF_VARS
################################################################################################


policy_name = "HTC_POC_USECASE2_618579_POLICY"
policy_description = "grant access to s3, Sns,CloudWatch,lambda,Glue"
role_name = "HTC_POC_USECASE2_618579_API_Lambda_Role"
policy_attachment = "attaching_polices_to_access_to_USECASE2_2_role"

#########################################################
#Lambda 
#########################################################
HTC_POC_USECASE2_618579_LambdaFunction_FileName = "./modules/lambda/data_conversion.py"
HTC_POC_USECASE2_618579_LambdaFunction_archives   = "./modules/lambda/archives/data_conversion.zip"
HTC_POC_USECASE2_618579_LambdaFunction   = "/archives/data_conversion.zip"
HTC_POC_USECASE2_618579_LambdaFunctionName = "HTC_POC_USECASE2_618579_LAMBDA"
HTC_POC_USECASE2_618579_LambdaFunction_Handler = "data_conversion.lambda_handler"
HTC_POC_USECASE2_618579_LambdaFunction_Runtime = "python3.12"
HTC_POC_USECASE2_618579_LambdaArn_Coded = "arn:aws:lambda:us-east-1:631328934344:function:HTC_POC_USECASE2_618579_DATA_CONVERSION_LAMBDA"

#########################################################
#Glue-Job
#########################################################
HTC_POC_USECASE2_618579_GlueJob_Name ="HTC_POC_USECASE22_618579_GlueJob"
HTC_POC_USECASE2_618579_GlueJob_Description ="glue job for checking Md5 checksum and Storing the Data into Ec2 Mysql"
HTC_POC_USECASE2_618579_GlueJob_Command_Name = "glueetl"
HTC_POC_USECASE2_618579_GlueJob_Script_Runtime = "Python 3"
HTC_POC_USECASE2_618579_GlueJob_Script_Name = "HTC_POC_USECASE2_618579_GlueJob"
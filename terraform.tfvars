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
  Name    = "POC_USECASE2"
  Project = "USECASE_2"
  Owner   = "Akhilesh"
  Creation_Date = "06-03-2024"
  Expiration_Date = "06=03-2024"
}

##########################################
#S3-Bucket
##########################################
POC_USECASE2_BUCKET_NAME="poc-usecase2-bucket"
POC_USECASE2_BUCKET_KEY_FOLDER = "row_data/"
CSV_FILE_PATH="./modules/data-file/xyz.csv"
POC_USECASE2_BUCKET_FOLDER_Glue_Script = "glue-script/glue_script.py"

###########################################
#SNS
###########################################
POC_USECASE2_SNS_NAME = "POC_USECASE2_TOPIC"
POC_USECASE2_SNS_SUBSCRIPTION_ENDPOINT = "your_email"
POC_USECASE2_SNS_SUBSCRIPTION_PROTOCOL = "email"

###########################################
#EC2
###########################################
POC_USECASE2_INSTANCE_AMI_ID = "ami-0c7217cdde317cfec"
POC_USECASE2_EC2_INSTANCE_TYPE = "t2.micro"
POC_USECASE2_vpc_security_group_ids = "sg-0bba45c045a7c6d5b"   # personal account
POC_USECASE2_key_name  = "awsPOC_USECASE2_key_pair"

################################################################################################
# IAM TF_VARS
################################################################################################


policy_name = "POC_USECASE2_POLICY"
policy_description = "grant access to s3, Sns,CloudWatch,lambda,Glue"
role_name = "POC_USECASE2_API_Lambda_Role"
policy_attachment = "attaching_polices_to_access_to_USECASE2_2_role"

#########################################################
#Lambda 
#########################################################
POC_USECASE2_LambdaFunction_FileName = "./modules/lambda/data_conversion.py"
POC_USECASE2_LambdaFunction_archives   = "./modules/lambda/archives/data_conversion.zip"
POC_USECASE2_LambdaFunction   = "/archives/data_conversion.zip"
POC_USECASE2_LambdaFunctionName = "POC_USECASE2_LAMBDA"
POC_USECASE2_LambdaFunction_Handler = "data_conversion.lambda_handler"
POC_USECASE2_LambdaFunction_Runtime = "python3.12"
POC_USECASE2_LambdaArn_Coded = "arn:aws:lambda:us-east-1:aws_id:function:POC_USECASE2_DATA_CONVERSION_LAMBDA"

#########################################################
#Glue-Job
#########################################################
POC_USECASE2_GlueJob_Name ="POC_USECASE2_GlueJob"
POC_USECASE2_GlueJob_Description ="glue job for checking Md5 checksum and Storing the Data into Ec2 Mysql"
POC_USECASE2_GlueJob_Command_Name = "glueetl"
POC_USECASE2_GlueJob_Script_Runtime = "Python 3"
POC_USECASE2_GlueJob_Script_Name = "POC_USECASE2_GlueJob"
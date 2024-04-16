# Glue Script 
# import sys
# import os
# import hashlib
# import logging
# from awsglue.transforms import *
# from awsglue.utils import getResolvedOptions
# from pyspark.context import SparkContext
# from awsglue.context import GlueContext
# from awsglue.job import Job
# from awsglue.dynamicframe import DynamicFrame
# from pyspark.sql.functions import *
# import boto3

# # Set up logging
# logging.basicConfig(filename='glue_job.log', level=logging.INFO)
# logger = logging.getLogger(__name__)

# args = getResolvedOptions(sys.argv, ['JOB_NAME', 'FILE_KEY', 'S3_BUCKET_NAME', 'SNS_TOPIC_ARN', 'PUBLIC_IP'])
# s3_bucket = args['S3_BUCKET_NAME']
# sns_topic_arn = args['SNS_TOPIC_ARN']
# ec2_public_ip = args['PUBLIC_IP']

# # Initialize Spark and Glue contexts
# sc = SparkContext()
# glueContext = GlueContext(sc)
# spark = glueContext.spark_session
# job = Job(glueContext)
# job.init(args['JOB_NAME'], args)

# # Function to notify SNS
# def notify_sns(message):
#     sns_client = boto3.client('sns')
#     if sns_topic_arn:
#         sns_client.publish(TopicArn=sns_topic_arn, Message=message, Subject="S3 Data Integrity Check")
#         logger.info(f"SNS notification sent: {message}")
#     else:
#         error_message = f"SNS topic ARN not provided. Unable to send notification. Message: {message}"
#         logger.error(error_message)
#         print(error_message)

# # Function to move file to folder
# def move_file_to_folder(file_key, folder):
#     s3_client = boto3.client('s3')
#     s3_client.copy_object(Bucket=s3_bucket, CopySource=f"{s3_bucket}/{file_key}", Key=f"{folder}{os.path.basename(file_key)}")
#     logger.info(f"File moved to folder: {file_key} -> {folder}")

# # Function to convert CSV to Parquet
# def convert_csv_to_parquet(file_key):
#     df = spark.read.option("header", "true").csv(f"s3://{s3_bucket}/{file_key}")
#     # Write DataFrame to Parquet
#     parquet_output_path = f"s3://{s3_bucket}/csv-parquet-conversion/{os.path.splitext(os.path.basename(file_key))[0]}.parquet"
#     df.write.parquet(parquet_output_path, mode="overwrite", compression="snappy")
#     logger.info(f"Converted and uploaded {file_key} to {parquet_output_path}")

# # Function to compute MD5 checksum
# def compute_md5(buffer, s3_client):
#     md5 = hashlib.md5()
#     md5.update(buffer)
#     return md5.hexdigest()

# # Process CSV file
# def process_csv_file(file_key):
#     try:
#         logger.info(f"Processing CSV file: {file_key}")
#         # Fetching ETag (MD5 hash) value from the file
#         s3_client = boto3.client('s3')
#         etag = s3_client.head_object(Bucket=s3_bucket, Key=file_key)['ETag'].strip('"')
#         # Calculate MD5 hash value from the content
#         response = s3_client.get_object(Bucket=s3_bucket, Key=file_key)
#         content_md5_hash = compute_md5(response['Body'].read(), s3_client)
#         # Compare ETag (MD5 hash) with calculated MD5 hash
#         if etag.lower() == content_md5_hash.lower():
#             logger.info(f"MD5 hashes match for file: {file_key}")
#             # Notify through SNS
#             notify_sns(f"New CSV file detected: {file_key}")
#             # Move the file to the 'processed' folder
#             move_file_to_folder(file_key, 'processed/')
#             # Convert CSV to Parquet
#             convert_csv_to_parquet(file_key)
#             # Define MySQL connection parameters
#             mysql_url = f"jdbc:mysql://{ec2_public_ip}:3306/customer_db"
#             mysql_properties = {
#                 "user": "root",
#                 "password": "Admin#123",
#                 "driver": "com.mysql.cj.jdbc.Driver",
#             }
#             mysql_table_name = "customer_table"
#             try:
#                 # Read Parquet file into DataFrame
#                 parquet_output_path = f"s3://{s3_bucket}/csv-parquet-conversion/{os.path.splitext(os.path.basename(file_key))[0]}.parquet"
#                 parquet_df = spark.read.parquet(parquet_output_path)
#                 # Write DataFrame to MySQL
#                 parquet_df.write.mode("overwrite").jdbc(url=mysql_url, table=mysql_table_name, properties=mysql_properties)
#                 logger.info("Data loaded into MySQL successfully.")
#             except Exception as e:
#                 error_message = f"Error writing to MySQL: {str(e)}"
#                 logger.error(error_message)
#                 print(error_message)
#         else:
#             logger.error(f"MD5 hashes do not match for file: {file_key}")
#             # Notify SNS about the error
#             notify_sns(f"Error: Data corrupted or lost for file: {file_key}")
#             # Move the file to the 'unmatched' folder
#             move_file_to_folder(file_key, 'unmatched/')
#     except Exception as e:
#         error_message = f"Error processing CSV file: {str(e)}"
#         logger.error(error_message)
#         # Notify SNS about the error
#         notify_sns(error_message)

# # Extract FILE_KEY from job arguments
# file_key = args['FILE_KEY']
# # Call the process_csv_file function
# process_csv_file(file_key)
# job.commit()




#new code with bookmark enable

import boto3
import sys
import os
import hashlib
import logging
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
 
# Set up logging
logging.basicConfig(filename='glue_job.log', level=logging.INFO)
logger = logging.getLogger(__name__)
 
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'FILE_KEY', 'S3_BUCKET_NAME', 'SNS_TOPIC_ARN', 'PUBLIC_IP'])
s3_bucket = args['S3_BUCKET_NAME']
sns_topic_arn = args['SNS_TOPIC_ARN']
ec2_public_ip = args['PUBLIC_IP']
 
# Initialize Spark and Glue contexts
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
 
# Function to notify SNS
def notify_sns(message):
    sns_client = boto3.client('sns')
    if sns_topic_arn:
        sns_client.publish(TopicArn=sns_topic_arn, Message=message, Subject="S3 Data Integrity Check")
        logger.info(f"SNS notification sent: {message}")
    else:
        error_message = f"SNS topic ARN not provided. Unable to send notification. Message: {message}"
        logger.error(error_message)
        print(error_message)
 
# Function to move file to folder
def move_file_to_folder(file_key, folder):
    s3_client = boto3.client('s3')
    s3_client.copy_object(Bucket=s3_bucket, CopySource=f"{s3_bucket}/{file_key}", Key=f"{folder}{os.path.basename(file_key)}")
    logger.info(f"File moved to folder: {file_key} -> {folder}")
 
# Function to convert CSV to Parquet
def convert_csv_to_parquet(file_key):
    df = spark.read.option("header", "true").csv(f"s3://{s3_bucket}/{file_key}")
    # Write DataFrame to Parquet
    parquet_output_path = f"s3://{s3_bucket}/csv-parquet-conversion/{os.path.splitext(os.path.basename(file_key))[0]}.parquet"
    df.write.parquet(parquet_output_path, mode="overwrite", compression="snappy")
    logger.info(f"Converted and uploaded {file_key} to {parquet_output_path}")
 
# Function to compute MD5 checksum
def compute_md5(buffer, s3_client):
    md5 = hashlib.md5()
    md5.update(buffer)
    return md5.hexdigest()
 
# Function to update bookmark
def update_bookmark(bookmark_key, value):
    s3_client = boto3.client('s3')
    s3_client.put_object(Bucket=s3_bucket, Key=bookmark_key, Body=value)
    logger.info(f"Bookmark updated: {value}")
 
# Function to retrieve bookmark
def get_bookmark(bookmark_key):
    s3_client = boto3.client('s3')
    try:
        response = s3_client.get_object(Bucket=s3_bucket, Key=bookmark_key)
        return response['Body'].read().decode('utf-8')
    except s3_client.exceptions.NoSuchKey:
        return None
 
# Process CSV file
def process_csv_file(file_key):
    try:
        logger.info(f"Processing CSV file: {file_key}")
        # Fetching ETag (MD5 hash) value from the file
        s3_client = boto3.client('s3')
        etag = s3_client.head_object(Bucket=s3_bucket, Key=file_key)['ETag'].strip('"')
        # Calculate MD5 hash value from the content
        response = s3_client.get_object(Bucket=s3_bucket, Key=file_key)
        content_md5_hash = compute_md5(response['Body'].read(), s3_client)
        # Compare ETag (MD5 hash) with calculated MD5 hash
        if etag.lower() == content_md5_hash.lower():
            logger.info(f"MD5 hashes match for file: {file_key}")
            # Notify through SNS
            notify_sns(f"New CSV file detected: {file_key}")
            # Move the file to the 'processed' folder
            move_file_to_folder(file_key, 'processed/')
            # Convert CSV to Parquet
            convert_csv_to_parquet(file_key)
            # Update bookmark
            update_bookmark('bookmark.txt', file_key)
            # Define MySQL connection parameters
            mysql_url = f"jdbc:mysql://{ec2_public_ip}:3306/customer_db"
            mysql_properties = {
                "user": "root",
                "password": "Admin#123",
                "driver": "com.mysql.cj.jdbc.Driver",
            }
            mysql_table_name = "customer_table"
            try:
                # Read Parquet file into DataFrame
                parquet_output_path = f"s3://{s3_bucket}/csv-parquet-conversion/{os.path.splitext(os.path.basename(file_key))[0]}.parquet"
                parquet_df = spark.read.parquet(parquet_output_path)
                # Write DataFrame to MySQL
                parquet_df.write.mode("overwrite").jdbc(url=mysql_url, table=mysql_table_name, properties=mysql_properties)
                logger.info("Data loaded into MySQL successfully.")
            except Exception as e:
                error_message = f"Error writing to MySQL: {str(e)}"
                logger.error(error_message)
                print(error_message)
        else:
            logger.error(f"MD5 hashes do not match for file: {file_key}")
            # Notify SNS about the error
            notify_sns(f"Error: Data corrupted or lost for file: {file_key}")
            # Move the file to the 'unmatched' folder
            move_file_to_folder(file_key, 'unmatched/')
    except Exception as e:
        error_message = f"Error processing CSV file: {str(e)}"
        logger.error(error_message)
        # Notify SNS about the error
        notify_sns(error_message)
 
# Extract FILE_KEY from job arguments
file_key = args['FILE_KEY']
# Retrieve bookmark
bookmark = get_bookmark('bookmark.txt')
if bookmark is None or bookmark == '':
    logger.info("No bookmark found. Processing all files.")
    process_csv_file(file_key)
elif file_key > bookmark:
    logger.info(f"Processing new files since bookmark: {bookmark}")
    process_csv_file(file_key)
else:
    logger.info(f"Skipping file: {file_key} (already processed)")
# Commit job
job.commit()
###########################################################
#Script for pushing csv file to s3 bucket row-data folder
###########################################################
import boto3
import hashlib
import os

#calcuating the md5 cheksum using the fie content
def calculate_md5(file_path):
    md5 = hashlib.md5()
    with open(file_path, 'rb') as file:
        while chunk := file.read(8192):
            md5.update(chunk)
    return md5.hexdigest()

def transfer_data_to_s3(file_path, bucket_name, object_key, aws_access_key, aws_secret_key, file_name):
    try:
        s3_client = boto3.client(
            's3',
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key
        )

        # Check if the bucket exists
        s3_client.head_bucket(Bucket=bucket_name)

        # Calculate MD5 before transfer
        md5_before_transfer = calculate_md5(file_path)
        print(f'MD5 Before Transfer: {md5_before_transfer}')

        # Upload the file to S3 with a specific filename
        s3_object_key = f'{object_key}/{file_name}'
        s3_client.upload_file(file_path, bucket_name, s3_object_key)

        # Calculate MD5 after transfer for the S3 object
        md5_after_transfer = s3_client.head_object(Bucket=bucket_name, Key=s3_object_key)['ETag'][1:-1].lower()
        print(f'MD5 After Transfer: {md5_after_transfer}')

        # Compare MD5 values
        if md5_before_transfer == md5_after_transfer:
            print("Data transfer successful. MD5 values match.")
        else:
            print("Data transfer may be corrupted. MD5 values do not match.")

    except Exception as e:
        print(f"Error: {str(e)}")
        print("Data transfer failed due to an error.")

if __name__ == "__main__":
    # Replace these values with your specific details
    file_path = 'C:/Users/akhilesh.pal/Documents/HTC_POC_USECASE_618579_TERRAFORM/modules/data-file/customer.csv'
    # bucket_name = 'my-test-b`ucket-618579'
    object_key = 'row_data'
    # aws_access_key = provide your aws_access_key
    # aws_secret_key = provide your aws_secret_key
    file_name = 'customer.csv'

    transfer_data_to_s3(file_path, bucket_name, object_key, aws_access_key, aws_secret_key, file_name)


import os
import boto3

def lambda_handler(event, context):
    # Fetch Glue job name from environment variable
    glue_job_name = os.environ.get('GLUE_JOB_NAME')
    if not glue_job_name:
        raise ValueError("GLUE_JOB_NAME environment variable is not set.")
    
    # Fetch file key from the S3 event
    file_key = event['Records'][0]['s3']['object']['key']
    print(f"S3 file key: {file_key}")

    # Start the Glue job
    glue = boto3.client('glue')
    response = glue.start_job_run(JobName=glue_job_name, Arguments={'--FILE_KEY': file_key})
    print(f"Glue job run response: {response}")

    # Optionally, you can log or handle the response
    print(f"Started Glue job run: {response['JobRunId']}")

    return {
        'statusCode': 200,
        'body': 'Glue job started successfully.'
    }

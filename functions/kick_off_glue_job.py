import boto3
import logging

# Initialize a boto3 client for Glue
glue_client = boto3.client('glue')


def onS3EventHandler(event, context):
  print("S3 Event Happened")
  record = event['Records'][0]
  try:
      # Specify the Glue job name you want to trigger
      glue_job_name = 'crime_data_pipeline'
      
      # Optionally, pass arguments to the Glue job (if needed)
      job_arguments = {
          '--bucket_name': record['s3']['bucket']['name'],  # Example argument, add as needed
          '--object_key': record['s3']['object']['key']
      }

      # Trigger the Glue job
      response = glue_client.start_job_run(
          JobName=glue_job_name,
          Arguments=job_arguments  # Optional, remove if not needed
      )

      # Log the response and return
      logging.info(f"Glue job {glue_job_name} started successfully: {response}")

      return {
          'statusCode': 200,
          'body': f"Glue job {glue_job_name} started successfully"
      }
      
  except Exception as e:
      logging.error(f"Error starting Glue job: {str(e)}")
      return {
          'statusCode': 500,
          'body': f"Error starting Glue job: {str(e)}"
      }
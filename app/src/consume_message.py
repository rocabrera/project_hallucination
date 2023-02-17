import json
import boto3

# Create SQS client
sqs = boto3.client('sqs')
s3 = boto3.resource('s3')

queue_url   = 'https://sqs.us-east-1.amazonaws.com/927636876491/gpu-process-queue'
bucket_name = '927636876491-protein-design'

# Receive message from SQS queue
response = sqs.receive_message(
    QueueUrl=queue_url,
    AttributeNames=[
        'SentTimestamp'
    ],
    MaxNumberOfMessages=1,
    VisibilityTimeout=0,
    WaitTimeSeconds=0
)

message = response['Messages'][0]
receipt_handle = message['ReceiptHandle']

body: dict = json.loads(message["Body"])

result = sum(body["data"])

s3.Object(bucket_name, 'result_file.txt').put(Body=str(result))

# Delete received message from queue
sqs.delete_message(
    QueueUrl=queue_url,
    ReceiptHandle=receipt_handle
)
print('Received and deleted message: %s' % message)

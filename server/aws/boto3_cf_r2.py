import os
import boto3
from botocore.client import Config


def init_s3(end_point, access_key, secret_key, region_name='auto'):
    return boto3.client(
        's3',
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        use_ssl=True,
        region_name=region_name,
        endpoint_url=end_point,
        config=Config(s3={"addressing_style": "path"})
    )


s3_endpoint = "https://2647fac2ea4d348bc0b7649fe6509e2a.r2.cloudflarestorage.com"
s3_access_key = os.getenv("CF_R2_ACCESS_KEY")
s3_secret_key = os.getenv("CF_R2_SECRET_KEY")
region_name = "auto"

s3 = init_s3(s3_endpoint, s3_access_key, s3_secret_key, region_name)

buckets = s3.list_buckets()

print(f"buckets: \n{buckets}")

file_name = "/Users/gavin.gao/Pictures/blue_car.jpg"
response = s3.put_object(Bucket=buckets["Buckets"][0]["Name"], Key=os.path.basename(file_name), Body=open(file_name, 'rb'))
if response['ResponseMetadata']['HTTPStatusCode'] == 200:
    print("Upload file successfully!")
else:
    print("Upload file failed!")

import os
import boto3
from botocore.client import Config
from torch.fx.experimental.unification.multipledispatch.dispatcher import source

from tqdm import tqdm


class Boto3CFR2:
    def __init__(self, end_point, access_key, secret_key, region_name='auto'):
        self.s3 = boto3.client(
            's3',
            aws_access_key_id=access_key,
            aws_secret_access_key=secret_key,
            use_ssl=True,
            region_name=region_name,
            endpoint_url=end_point,
            config=Config(s3={"addressing_style": "path"})
        )

    def list_buckets(self):
        return self.s3.list_buckets()['Buckets']

    def upload_file(self, bucket_name, file_path):
        response = self.s3.put_object(Bucket=bucket_name, Key=os.path.basename(file_path),
                                      Body=open(file_path, 'rb'))
        if response['ResponseMetadata']['HTTPStatusCode'] == 200:
            return True
        else:
            return False

    def copy_file(self, bucket_name, file_src_path, file_dest_path):
        self.s3.copy_object(
            Bucket=bucket_name,
            CopySource={'Bucket': bucket_name, 'Key': file_src_path},
            Key=file_dest_path
        )

    def list_files(self, bucket_name, source_dir):
        paginator = self.s3.get_paginator('list_objects_v2')
        pages = paginator.paginate(Bucket=bucket_name, Prefix=source_dir)
        file_keys = []
        for page in pages:
            for obj in page['Contents']:
                obj_key = obj['Key']
                file_keys.append(obj_key)
        return file_keys


s3_endpoint = "https://2647fac2ea4d348bc0b7649fe6509e2a.r2.cloudflarestorage.com"
s3_access_key = os.getenv("CF_R2_ACCESS_KEY")
s3_secret_key = os.getenv("CF_R2_SECRET_KEY")
s3_bucket_name = "assets-website"

cfr2_s3 = Boto3CFR2(s3_endpoint, s3_access_key, s3_secret_key)

buckets = cfr2_s3.list_buckets()

print(f"buckets: \n{buckets}")

file_name = "/Users/gavin.gao/Pictures/BlueCar.jpg"
ret = cfr2_s3.upload_file(s3_bucket_name, file_name)
if ret:
    print("Upload file successfully!")
else:
    print("Upload file failed!")

source_dir = "ob"
target_dir = "./"
file_keys = cfr2_s3.list_files(s3_bucket_name, source_dir)

with tqdm(total=len(file_keys), desc='Moving Files', unit='file') as pbar:
    for old_key in file_keys:
        new_key = old_key.replace(source_dir, target_dir, 1)
        pbar.update(1)

        # try:
        #     cfr2_s3.copy_file(s3_bucket_name, old_key, new_key)
        #     print(f"Successfully copied: {old_key} → {new_key}")
        #     pbar.update(1)
        # except Exception as e:
        #     print(f"Error processing {old_key}: {str(e)}")
        #     pbar.update(1)  # 即使出错，继续进度条

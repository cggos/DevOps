import boto3


def test_s3() -> None:
    # 创建S3资源对象
    s3 = boto3.resource("s3")
    # 创建一个新的S3桶
    bucket = s3.create_bucket(Bucket="my-new-bucket")
    # 上传文件
    s3.Object("my-new-bucket", "my-file.txt").put(Body=open("my-file.txt", "rb"))
    # 列出桶里的对象
    for _obj in bucket.objects.all():
        pass


def test_ec2() -> None:
    # 创建EC2资源对象
    ec2 = boto3.resource("ec2")
    # 启动新的EC2实例
    ec2.create_instances(
        ImageId="ami-0abcdef1234567890",
        MinCount=1,
        MaxCount=1,
        InstanceType="t2.micro",
    )


def test_dynamodb() -> None:
    # 创建DynamoDB资源对象
    dynamodb = boto3.resource("dynamodb")
    # 创建表
    table = dynamodb.create_table(
        TableName="MyTable",
        KeySchema=[
            {"AttributeName": "username", "KeyType": "HASH"},  # 分区键
            {"AttributeName": "last_name", "KeyType": "RANGE"},  # 排序键
        ],
        AttributeDefinitions=[
            {"AttributeName": "username", "AttributeType": "S"},
            {"AttributeName": "last_name", "AttributeType": "S"},
        ],
        ProvisionedThroughput={"ReadCapacityUnits": 10, "WriteCapacityUnits": 10},
    )
    # 插入数据
    table.put_item(
        Item={
            "username": "janedoe",
            "last_name": "Doe",
            "age": 25,
            "email": "janedoe@example.com",
        },
    )
    # 查询数据
    table.get_item(Key={"username": "janedoe", "last_name": "Doe"})

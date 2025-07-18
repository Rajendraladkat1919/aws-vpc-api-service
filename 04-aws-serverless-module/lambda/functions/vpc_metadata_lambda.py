import json
import boto3
import os

def lambda_handler(event, context):
    region = os.environ.get('AWS_REGION', 'us-east-1')
    dynamodb = boto3.resource('dynamodb', region_name=region)
    table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'vpc_metadata')
    table = dynamodb.Table(table_name)

    method = event.get('httpMethod', event.get('requestContext', {}).get('http', {}).get('method', 'GET'))

    if method == 'PUT':
        body = event.get('body')
        if body:
            data = json.loads(body)
            vpc_id = data.get('vpc_id')
            subnet_id = data.get('subnet_id')
            item = {
                'id': vpc_id,
                'vpc_id': vpc_id,
                'subnet_id': subnet_id,
                'region': region,
                'metadata': data
            }
            table.put_item(Item=item)
            return {
                'statusCode': 201,
                'body': json.dumps({'message': 'VPC metadata stored', 'item': item})
            }
        return {'statusCode': 400, 'body': json.dumps({'error': 'Missing body'})}

    elif method == 'GET':
        response = table.scan()
        items = response.get('Items', [])
        return {
            'statusCode': 200,
            'body': json.dumps({'items': items})
        }

    return {'statusCode': 405, 'body': json.dumps({'error': 'Method Not Allowed'})}

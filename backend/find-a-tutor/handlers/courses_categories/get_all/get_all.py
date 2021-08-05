import json

def handle(event, context):

    print(event)

    response = {
        'statusCode': 200,
        'body': 'Hello World',
    }

    return response
import boto3
from botocore.exceptions import ClientError


client = boto3.client("ses", region_name="us-east-1")


def handle(event, context):

    email = event["arguments"]["email"]
    user_id = event["arguments"]["user_id"]
    subject = event["arguments"]["subject"]
    text = event["arguments"]["text"]

    # Replace sender@example.com with your "From" address.
    # This address must be verified with Amazon SES.
    SENDER = "nathangngencissk@gmail.com"

    # Replace recipient@example.com with a "To" address. If your account
    # is still in the sandbox, this address must be verified.
    RECIPIENT = "nathangngencissk@gmail.com"

    # Specify a configuration set. If you do not want to use a configuration
    # set, comment the following variable, and the
    # ConfigurationSetName=CONFIGURATION_SET argument below.
    # CONFIGURATION_SET = "ConfigSet"

    # The subject line for the email.
    SUBJECT = "Contato Find a Tutor"

    # The email body for recipients with non-HTML email clients.
    BODY_TEXT = f"{subject}\r\n" f"{user_id} - {email}" f"{text}"

    # The HTML body of the email.
    BODY_HTML = f"""<html>
            <head></head>
            <body>
                <h1>{subject}</h1>
                <p>user id: {user_id}</p>
                <p>user email: {email}</p>
                <p>text: {text}</p>
            </body>
        </html>
    """

    # The character encoding for the email.
    CHARSET = "UTF-8"

    try:
        # Provide the contents of the email.
        response = client.send_email(
            Destination={
                "ToAddresses": [
                    RECIPIENT,
                ],
            },
            Message={
                "Body": {
                    "Html": {
                        "Charset": CHARSET,
                        "Data": BODY_HTML,
                    },
                    "Text": {
                        "Charset": CHARSET,
                        "Data": BODY_TEXT,
                    },
                },
                "Subject": {
                    "Charset": CHARSET,
                    "Data": SUBJECT,
                },
            },
            Source=SENDER,
            # If you are not using a configuration set, comment or delete the
            # following line
            # ConfigurationSetName=CONFIGURATION_SET,
        )
    # Display an error if something goes wrong.
    except ClientError as e:
        print(e.response["Error"]["Message"])
    else:
        print("Email sent! Message ID:"),
        print(response["MessageId"])

    return "email enviado com sucesso!"

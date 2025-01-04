import json

from services.telegram import send_message


def handle_message(message):
    if (text := message.get("text")) and text == "/start":
        pass

    else:
        send_message("Ошибка", message)

def handler(event, context):
    update = json.loads(event["body"])
    message = update.get("message")

    if message:
        handle_message(message)

    return {
        "statusCode": 200,
    }
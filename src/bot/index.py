import json

from services.telegram import send_message, send_photo
from services.yandex_cloud import get_face_without_name
from settings import API_GATEWAY_URL


def handle_message(message):
    if (text := message.get("text")) and text == "/start":
        pass

    elif text := message.get("text") and text == "/getface":
        object_key = get_face_without_name()
        if not object_key:
            send_message("Нет лиц с незаданным именем", message)
            return

        send_photo(f"{API_GATEWAY_URL}?face={object_key}", message)

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

import requests

from settings import TELEGRAM_API_URL


def send_message(reply_text, input_message):
    url = f"{TELEGRAM_API_URL}/sendMessage"

    data = {
        "chat_id": input_message["chat"]["id"],
        "text": reply_text,
        "reply_parameters": {
            "message_id": input_message["message_id"],
        },
    }

    requests.post(url=url, json=data)

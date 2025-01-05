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


def send_photo(photo_url, input_message):
    url = f"{TELEGRAM_API_URL}/sendPhoto"

    data = {
        "chat_id": input_message["chat"]["id"],
        "photo": photo_url,
        "reply_parameters": {
            "message_id": input_message["message_id"],
        },
    }

    response = requests.post(url=url, json=data)

    return response.json()["result"]["photo"][-1]["file_unique_id"]

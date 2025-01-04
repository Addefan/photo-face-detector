import json

from services.yandex_cloud import get_image, save_image
from utils import crop_image


def handler(event, context):
    message = json.loads(event["messages"][0]["details"]["message"]["body"])
    object_key, rect = message["object_key"], message["rectangle"]

    image = get_image(object_key)
    face = crop_image(image, rect)
    save_image(face)

    return {
        "statusCode": 200,
    }

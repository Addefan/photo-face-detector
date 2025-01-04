import uuid
from pathlib import Path

from PIL import Image

from settings import PHOTOS_MOUNT_POINT, FACES_MOUNT_POINT


def get_image(object_key):
    with Image.open(Path("/function/storage", PHOTOS_MOUNT_POINT, object_key)) as image:
        image.load()
    return image


def save_image(image):
    image.save(Path("/function/storage", FACES_MOUNT_POINT, f"{uuid.uuid4()}.jpg"))

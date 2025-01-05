from pathlib import Path

from PIL import Image
from services.images import get_name

from settings import FACES_MOUNT_POINT


def get_face_without_name():
    for image_path in Path("/function/storage", FACES_MOUNT_POINT).iterdir():
        with Image.open(image_path) as image:
            image.load()

        if not get_name(image):
            return image_path.name

from typing import Literal

import piexif

Idf = Literal["0th", "Exif", "GPS", "1st", "thumbnail"]


def get_value_from_metadata(image, idf: Idf, key):
    if not (exif := image.info.get("exif")):
        return None

    exif = piexif.load(exif)
    value = exif[idf].get(key)

    if not value:
        return None

    return value.decode("utf-8")


def get_original_path(image):
    return get_value_from_metadata(image, "0th", piexif.ImageIFD.ImageDescription)


def get_name(image):
    return get_value_from_metadata(image, "Exif", piexif.ExifIFD.UserComment)

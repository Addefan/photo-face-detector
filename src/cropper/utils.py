def crop_image(image, rect):
    x, y, w, h = rect
    return image.crop((x, y, x + w, y + h))

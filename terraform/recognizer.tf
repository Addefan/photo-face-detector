resource "yandex_storage_bucket" "photos_bucket" {
  bucket = "vvot26-photo"
}

resource "yandex_function" "recognizer" {
  name               = "vvot26-face-detection"
  entrypoint         = "index.handler"
  memory             = "128"
  runtime            = "python312"
  user_hash          = data.archive_file.recognizer_source.output_sha512
  execution_timeout  = "30"
  service_account_id = yandex_iam_service_account.sa_recognizer.id
  environment = {
    TELEGRAM_BOT_TOKEN = var.tg_bot_key
    FOLDER_ID          = var.folder_id
    MOUNT_POINT        = yandex_storage_bucket.photos_bucket.bucket
  }
  content {
    zip_filename = data.archive_file.recognizer_source.output_path
  }
  mounts {
    name = yandex_storage_bucket.photos_bucket.bucket
    mode = "ro"
    object_storage {
      bucket = yandex_storage_bucket.photos_bucket.bucket
    }
  }
}

resource "yandex_function_trigger" "photos_bucket_trigger" {
  name = "vvot26-photo"
  function {
    id                 = yandex_function.recognizer.id
    service_account_id = yandex_iam_service_account.sa_recognizer.id
  }
  object_storage {
    bucket_id    = yandex_storage_bucket.photos_bucket.id
    suffix       = ".jpg"
    create       = true
    batch_cutoff = "0"
  }
}

data "archive_file" "recognizer_source" {
  type        = "zip"
  source_dir  = "../src/recognizer"
  output_path = "../build/recognizer.zip"
}

resource "yandex_iam_service_account" "sa_recognizer" {
  name = "sa-recognizer"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_recognizer_function_invoker_role" {
  folder_id = var.folder_id
  role      = "functions.functionInvoker"
  member    = "serviceAccount:${yandex_iam_service_account.sa_recognizer.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_recognizer_storage_viewer_iam" {
  folder_id = var.folder_id
  role      = "storage.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.sa_recognizer.id}"
}

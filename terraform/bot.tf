resource "yandex_function" "bot" {
  name               = "vvot00-boot"
  entrypoint         = "index.handler"
  memory             = "128"
  runtime            = "python312"
  user_hash          = data.archive_file.bot_source.output_sha512
  service_account_id = yandex_iam_service_account.sa_bot.id
  environment = {
    TELEGRAM_BOT_TOKEN = var.tg_bot_key
    PHOTOS_MOUNT_POINT = yandex_storage_bucket.photos_bucket.bucket
    FACES_MOUNT_POINT  = yandex_storage_bucket.faces_bucket.bucket
  }
  content {
    zip_filename = data.archive_file.bot_source.output_path
  }
  mounts {
    name = yandex_storage_bucket.photos_bucket.bucket
    mode = "ro"
    object_storage {
      bucket = yandex_storage_bucket.photos_bucket.bucket
    }
  }
  mounts {
    name = yandex_storage_bucket.faces_bucket.bucket
    mode = "rw"
    object_storage {
      bucket = yandex_storage_bucket.faces_bucket.bucket
    }
  }
}

resource "yandex_function_iam_binding" "exam_solver_tg_bot_iam" {
  function_id = yandex_function.bot.id
  role        = "functions.functionInvoker"
  members = [
    "system:allUsers",
  ]
}

resource "telegram_bot_webhook" "exam_solver_tg_bot_webhook" {
  url = "https://functions.yandexcloud.net/${yandex_function.bot.id}"
}

data "archive_file" "bot_source" {
  type        = "zip"
  source_dir  = "../src/bot"
  output_path = "../build/bot.zip"
}

resource "yandex_iam_service_account" "sa_bot" {
  name = "sa-bot"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_bot_storage_editor_iam" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa_bot.id}"
}

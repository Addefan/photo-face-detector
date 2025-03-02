variable "cloud_id" {
  type        = string
  description = "Идентификатор облака по умолчанию"
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога по умолчанию"
}

variable "sa_key_file_path" {
  type        = string
  description = "Путь к ключу сервисного аккаунта с ролью admin"
  default     = "~/.yc-keys/key.json"
}

variable "tg_bot_key" {
  type        = string
  description = "Токен telegram-бота"
}

variable "photos_bucket" {
  type        = string
  description = "Название бакета для оригинальных фотографий"
  default     = "vvot26-photo"
}

variable "face_detection_function" {
  type        = string
  description = "Название функции для обнаружения лиц"
  default     = "vvot26-face-detection"
}

variable "face_detection_trigger" {
  type        = string
  description = "Название триггера бакета для обнаружения лиц"
  default     = "vvot26-photo"
}

variable "face_cut_queue" {
  type        = string
  description = "Название очереди для заданий по обрезке лиц"
  default     = "vvot26-task"
}

variable "sa_face_detection" {
  type        = string
  description = "Имя сервисного аккаунта для функции обнаружения лиц"
  default     = "sa-recognizer"
}

variable "faces_bucket" {
  type        = string
  description = "Название бакета для фотографий лиц"
  default     = "vvot26-faces"
}

variable "face_cut_function" {
  type        = string
  description = "Название функции для обрезания лиц"
  default     = "vvot26-face-cut"
}

variable "face_cut_trigger" {
  type        = string
  description = "Название триггера очереди для заданий обрезки лиц"
  default     = "vvot26-task"
}

variable "sa_face_cut" {
  type        = string
  description = "Имя сервисного аккаунта для функции обрезки лиц"
  default     = "sa-cropper"
}

variable "bot_function" {
  type        = string
  description = "Название функции для Telegram-бота"
  default     = "vvot26-boot"
}

variable "api_gateway" {
  type        = string
  description = "Название API-шлюза для фотографий лиц"
  default     = "vvot26-apigw"
}

variable "sa_bot" {
  type        = string
  description = "Имя сервисного аккаунта для функции для Telegram-бота"
  default     = "sa-bot"
}

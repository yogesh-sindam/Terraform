variable "bucket_name" {
  type = string
}

variable "versioning" {
  type = bool
}

variable "tags" {
  type = map(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
# variable "region" {
#   description = "AWS region"
#   type        = string
# }
variable "function_name" {}
variable "runtime" {}
variable "handler" {}
variable "memory_size" { default = 128 }
variable "timeout" { default = 3 }
variable "source_path" {}
variable "environment_variables" {
  type    = map(string)
  default = {}
}
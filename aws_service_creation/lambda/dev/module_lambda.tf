provider "aws" {
  region = "ap-south-1"
}

module "lambda" {
  source = "../modules/lambda"

  function_name = "myapp-${var.env}"
  runtime       = "python3.11"
  handler       = "index.handler"
  source_path   = "lambda.zip"

  memory_size = 256
  timeout     = 10

  environment_variables = {
    ENV        = var.env
    LOG_LEVEL  = "debug"
  }
}
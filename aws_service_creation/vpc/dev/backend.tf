terraform {
  backend "s3" {
    bucket = "vpc"
    key    = "vpc/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
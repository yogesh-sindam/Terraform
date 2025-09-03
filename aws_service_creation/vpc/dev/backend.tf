terraform {
  backend "s3" {
    bucket = "vpc"
    key    = "vpc/dev"
    region = "us-east-1"
  }
}
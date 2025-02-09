terraform {
  backend "s3" {
    bucket         = "creating-for-remoteandstatelocking" # change this
    key            = "abhi/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

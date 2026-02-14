terraform {
  backend "s3" {
    bucket         = "remote-state-backend-dev-yogi" # change this
    key            = "Terrafrom-documents/aws_service_creation/s3/remote-state/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    #dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1" # change as per your requirement
}

module "vpc" {
  source = "./_module"

  vpc_cidr = "10.50.0.0/16"

  public_subnet_cidrs = [
    "10.50.1.0/24",
    "10.50.2.0/24",
    "10.50.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.50.10.0/24",
    "10.50.11.0/24",
    "10.50.12.0/24"
  ]

  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

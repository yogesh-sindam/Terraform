variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = string
}

variable "key_pair_name" {
  description = "The name of the key pair for SSH access."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
  default     = "my-terraform-ec2"
}

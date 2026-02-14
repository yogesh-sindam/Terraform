
############################
# Reference Existing IAM User
############################

data "aws_iam_user" "existing_user" {
  user_name = "terraform_login"
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
############################
# Create Full Bucket Access Policy (Only This Bucket)
############################
data "aws_iam_policy_document" "bucket_full_access" {

  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
  }
}

############################
# Attach Policy to IAM User
############################

resource "aws_iam_user_policy" "terraform_login_bucket_access" {
  name   = "terraform-login-bucket-full-access"
  user   = data.aws_iam_user.existing_user.user_name
  policy = data.aws_iam_policy_document.bucket_full_access.json
}
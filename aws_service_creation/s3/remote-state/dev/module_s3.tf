module "s3_bucket" {
  source = "../_module"
  aws_region =  var.aws_region 
  bucket_name = var.bucket_name
  versioning  = var.versioning
  tags        = var.tags
}

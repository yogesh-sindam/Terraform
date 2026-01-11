resource "aws_cloudfront_distribution" "alpha" {
  enabled = true
  aliases = ["alpha.com"]

  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.root.bucket_regional_domain_name
    origin_id                = "root-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  origin {
    domain_name              = aws_s3_bucket.images.bucket_regional_domain_name
    origin_id                = "images-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  origin {
    domain_name              = aws_s3_bucket.app1.bucket_regional_domain_name
    origin_id                = "app1-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }
origin {
  domain_name = aws_lb.app.dns_name
  origin_id   = "alb-origin"

  custom_origin_config {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "https-only"
    origin_ssl_protocols   = ["TLSv1.2"]
  }
}
## ELB with cloudfron 

  origin {
    domain_name              = aws_s3_bucket.app2.bucket_regional_domain_name
    origin_id                = "app2-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  ### DEFAULT ( / )
  default_cache_behavior {
    target_origin_id       = "root-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.app1.qualified_arn
      include_body = false
    }
  }

  ### /images/*
  ordered_cache_behavior {
    path_pattern           = "/images/*"
    target_origin_id       = "images-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.app1.qualified_arn
    }
  }

  ### /app1/*
  ordered_cache_behavior {
    path_pattern           = "/app1/*"
    target_origin_id       = "app1-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = aws_lambda_function.app1.qualified_arn
    }
  }

  ### /app2/*
  ordered_cache_behavior {
    path_pattern           = "/app2/*"
    target_origin_id       = "app2-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = aws_lambda_function.app1.qualified_arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
}
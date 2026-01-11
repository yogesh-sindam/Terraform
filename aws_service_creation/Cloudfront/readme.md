aws_cloudfront_distribution (Top Level)
Copy code
Hcl
resource "aws_cloudfront_distribution" "alpha" {
  enabled = true
  aliases = ["alpha.com"]
  default_root_object = "index.html"
What this means
Creates one CloudFront distribution
enabled = true → distribution is live
aliases → custom domain mapped to CloudFront
default_root_object
When user hits https://alpha.com/
CloudFront automatically requests index.html
📌 Without this, / would return 403 or 404 from S3.
2️⃣ origin Blocks (Backends)
Each origin is a backend destination CloudFront can forward requests to.
Example: Root Origin
Copy code
Hcl
origin {
  domain_name              = aws_s3_bucket.root.bucket_regional_domain_name
  origin_id                = "root-origin"
  origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
}
What happens
domain_name → actual backend endpoint (S3 bucket DNS)
origin_id → logical name used later in cache behaviors
origin_access_control_id
Enables OAC
S3 bucket is private
Only CloudFront can access it
📌 CloudFront never serves content directly from S3 — it always uses an origin.
Why multiple origins?
Copy code
Text
/images/* → images bucket
/app1/*   → app1 bucket
/app2/*   → app2 bucket
/         → root bucket
This gives logical isolation and independent scaling.
3️⃣ default_cache_behavior (Catch-All Rule)
Copy code
Hcl
default_cache_behavior {
  target_origin_id       = "root-origin"
  viewer_protocol_policy = "redirect-to-https"
Purpose
Handles all requests that do NOT match any ordered behavior
Mandatory block (CloudFront won’t work without it)
📌 Think of this as:
“If nothing else matches, use this.”
Protocol Handling
Copy code
Hcl
viewer_protocol_policy = "redirect-to-https"
If user uses HTTP
CloudFront sends 301 redirect to HTTPS
HTTP Methods
Copy code
Hcl
allowed_methods = ["GET", "HEAD"]
cached_methods  = ["GET", "HEAD"]
Only allows read-only methods
Safe for static content
Improves caching & security
Lambda@Edge (Default Path)
Copy code
Hcl
lambda_function_association {
  event_type   = "viewer-request"
  lambda_arn   = aws_lambda_function.app1.qualified_arn
}
What this does
Executes before cache lookup
Runs at edge location
Typical use cases:
Authentication
Redirects
Header manipulation
📌 Viewer Request = before CloudFront cache
4️⃣ ordered_cache_behavior (Path-Based Routing)
CloudFront evaluates ordered behaviors first, then falls back to default.
🔹 /images/*
Copy code
Hcl
ordered_cache_behavior {
  path_pattern     = "/images/*"
  target_origin_id = "images-origin"
Meaning
Requests matching /images/*
Forwarded to images S3 bucket
Lambda Trigger
Copy code
Hcl
lambda_function_association {
  event_type = "origin-request"
}
Origin Request means
Lambda runs only on cache miss
Just before contacting S3
📌 Common use:
Remove /images prefix
Add custom headers
🔹 /app1/*
Copy code
Hcl
ordered_cache_behavior {
  path_pattern     = "/app1/*"
  target_origin_id = "app1-origin"
Why separate behavior?
Different app
Different cache rules
Different auth logic
OPTIONS Allowed
Copy code
Hcl
allowed_methods = ["GET", "HEAD", "OPTIONS"]
Required for CORS
Common for SPAs / APIs
Viewer Request Lambda
Copy code
Hcl
event_type = "viewer-request"
Runs:
Before cache
On every request
Best for authentication
🔹 /app2/*
Same logic as /app1/* but points to another origin.
5️⃣ Behavior Matching Order (IMPORTANT)
CloudFront matches:
/images/*
/app1/*
/app2/*
default_cache_behavior
📌 Most specific path wins
6️⃣ restrictions (Geo Control)
Copy code
Hcl
geo_restriction {
  restriction_type = "none"
}
No country restrictions
Could be changed to whitelist/blacklist
7️⃣ viewer_certificate (TLS / HTTPS)
Copy code
Hcl
viewer_certificate {
  acm_certificate_arn = aws_acm_certificate.cert.arn
  ssl_support_method  = "sni-only"
}
What happens
TLS termination at CloudFront
Certificate must be in us-east-1
Enables https://alpha.com
🔁 Runtime Flow (End-to-End)
User requests:
Copy code

https://alpha.com/app1/dashboard
Flow:
Route53 → CloudFront
CloudFront matches /app1/*
Viewer Request Lambda runs
Cache hit?
Yes → return response
No → forward to app1 S3 bucket
Response cached
Returned to user
✅ Interview One-Line Summary
CloudFront uses origins as backends and cache behaviors for path-based routing. Ordered behaviors are evaluated first, default behavior acts as fallback, and Lambda@Edge enables request processing at different lifecycle stages
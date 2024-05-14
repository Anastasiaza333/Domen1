module "labels" {
  source = "cloudposse/label/null"
    name = var.name
    stage = var.stage
}

locals {
  s3_origin_id = "myS3Origin"
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [ aws_cloudfront_origin_access_identity.default ]
 origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "myS3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"



   default_cache_behavior {
    compress               = true
    target_origin_id       = "myS3Origin"
    viewer_protocol_policy = "allow-all"

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

    }
  }


  price_class = "PriceClass_200"

 viewer_certificate {
    cloudfront_default_certificate = true
  }

    restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "comment"
}
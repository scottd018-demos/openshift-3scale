data "aws_caller_identity" "current" {}

#
# s3
#
resource "aws_s3_bucket" "three_scale" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_cors_configuration" "three_scale" {
  bucket = aws_s3_bucket.three_scale.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["https://*"]
  }
}

#
# iam
#
locals {
  s3_bucket_three_scale_policy_json = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::'${var.s3_bucket_name}'",
                "arn:aws:s3:::'${var.s3_bucket_name}'/*"
            ]
        }
    ]
}
EOT
}

resource "aws_iam_user" "three_scale" {
  name = var.s3_bucket_name
}

resource "aws_iam_access_key" "three_scale" {
  user = aws_iam_user.three_scale.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = var.s3_bucket_name
  user   = aws_iam_user.three_scale.name
  policy = local.s3_bucket_three_scale_policy_json
}

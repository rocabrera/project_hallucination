resource "aws_s3_bucket" "bucket" {
  bucket = "${var.account_id}-${var.bucket_name}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "wte-mongo-backup" {
  bucket = "wte-mongo-backup" # Ensure this name is globally unique
}

resource "aws_s3_bucket_acl" "wte-mongo-backup_acl" {
  bucket = aws_s3_bucket.wte-mongo-backup.bucket
  acl    = "public"
}

resource "aws_s3_bucket_public_access_block" "wte-mongo-backup-public-allow" {
  bucket = aws_s3_bucket.wte-mongo-backup.bucket

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

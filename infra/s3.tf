resource "aws_s3_bucket" "wte-mongo-backup" {
  bucket = "wte-mongo-backup" # Ensure this name is globally unique
}

resource "aws_s3_bucket_acl" "wte-mongo-backup_acl" {
  bucket = aws_s3_bucket.wte-mongo-backup.bucket
  acl    = "public-read"
}

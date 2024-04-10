resource "aws_s3_bucket" "wte-mongo-backup" {
  bucket = "wte-mongo-backup" # Ensure this name is globally unique
}

resource "aws_s3_bucket_acl" "wte-mongo-backup_acl" {
  bucket = aws_s3_bucket.wte-mongo-backup.bucket
  acl    = "public-read"
}

data "aws_iam_policy_document" "read_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::wte-mongo-backup"]
  }
}

resource "aws_s3_bucket_policy" "read_access" {
  bucket = aws_s3_bucket.wte-mongo-backup.bucket
  policy = data.aws_iam_policy_document.read_access.json

}

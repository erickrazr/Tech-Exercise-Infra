provider "aws" {
  region = "us-east-1" # You can change this to your preferred AWS region
}

resource "aws_s3_bucket" "wte-mongo-bkp" {
  bucket = "wte-mongo-bkp" # Ensure this name is globally unique
  acl    = "public-read"      # This makes the bucket publicly readable

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::wte-mongo-bkp/*"
    }
  ]
}
POLICY
}

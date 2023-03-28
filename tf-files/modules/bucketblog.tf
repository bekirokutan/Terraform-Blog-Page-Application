resource "aws_s3_bucket" "s3-blog" {
  bucket = var.s3_bucket_name_blog
  force_destroy = true
}

resource "aws_s3_bucket_acl" "s3-blog-acl" {
  bucket = aws_s3_bucket.s3-blog.bucket
  acl    = "public-read"
}
resource "aws_s3_bucket_policy" "s3-blog-policy" {
  bucket = aws_s3_bucket.s3-blog.bucket
   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::awscapstonesbekirblog/*"
      }
    ]
  })
}

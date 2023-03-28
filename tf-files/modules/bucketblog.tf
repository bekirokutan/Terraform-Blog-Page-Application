resource "aws_s3_bucket" "s3-blog" {
  bucket = var.s3_bucket_name_blog
  # acl    = "public-read"
  force_destroy = true
  
  tags = {
    Name        = "blog-bucket"
    Environment = "development"
  }
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.s3-blog.id
  acl    = "public-read"
}
data "aws_acm_certificate" "cert" {
  domain   = var.hostname
  statuses = ["ISSUED"]
}
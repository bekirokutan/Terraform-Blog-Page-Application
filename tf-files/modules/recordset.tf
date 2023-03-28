resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.capstone.zone_id
  name    = var.subdomain_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.capstonedist.domain_name
    zone_id                = aws_cloudfront_distribution.capstonedist.hosted_zone_id
    evaluate_target_health = true
  }
}
data "aws_route53_zone" "capstone" {
  name = var.hostname
}
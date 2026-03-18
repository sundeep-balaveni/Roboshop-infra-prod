resource "aws_route53_record" "mongodb" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "mongodb-${var.env}-${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "redis-${var.env}-${var.domain_name}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}
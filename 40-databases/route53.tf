resource "aws_route53_record" "mongodb" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "mongodb-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mongo-db.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "redis-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "mysql-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}
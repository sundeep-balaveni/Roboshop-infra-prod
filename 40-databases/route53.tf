resource "aws_route53_record" "mongodb" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "mongodb-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mongo-db.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "redis-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "mysql-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "backend_alb" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "*.backend_alb-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}
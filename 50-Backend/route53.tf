resource "aws_route53_record" "mongodb" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "catalogue-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
}



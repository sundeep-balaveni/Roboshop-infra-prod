resource "aws_route53_record" "mongodb" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "catalogue-${var.env}"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
}



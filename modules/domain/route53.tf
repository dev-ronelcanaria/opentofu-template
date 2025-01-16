resource "aws_route53_record" "record_cname_www_api_app" {
  zone_id = var.app_domain_zone_id
  name = "www.${var.app_listener_host_header}"
  type = "CNAME"
  ttl = 300

  records = [
    var.app_listener_host_header
  ]
}

resource "aws_route53_record" "api_prod_domain" {
  zone_id = var.app_domain_zone_id
  name = var.app_listener_host_header
  type = "A"

  alias {
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}
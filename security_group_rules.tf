# 1. ALB Ingress (Allow HTTP/HTTPS from Internet)
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTPS from internet"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTPS from internet"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# 2. ALB Egress (Allow to App SG on port 8080)
resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id            = aws_security_group.alb.id
  description                  = "Allow HTTPS from internet"
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

# 3. App Ingress (Allow from ALB SG on port 8080)
resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  description                  = "Allow HTTPS from internet"
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

# 4. App Egress (Allow to DB SG on port 5432)
resource "aws_vpc_security_group_egress_rule" "Allow App to reach Database" {
  security_group_id            = aws_security_group.app.id
  description                  = "Allow HTTPS from internet"
  referenced_security_group_id = aws_security_group.db.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# 5. DB Ingress (Allow from App SG on port 5432)
resource "aws_vpc_security_group_ingress_rule" "Allow Database traffic from App" {
  security_group_id            = aws_security_group.db.id
  description                  = "Allow HTTPS from internet"
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}
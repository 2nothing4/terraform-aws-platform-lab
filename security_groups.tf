# checkov:skip=CKV2_AWS_5:Security groups will be attached to compute resources in a future phase.
resource "aws_security_group" "alb" {
  name_prefix = "${var.project_name}-alb-"
  description = "Security group for the Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# checkov:skip=CKV2_AWS_5:Security groups will be attached to compute resources in a future phase.
resource "aws_security_group" "app" {
  name_prefix = "${var.project_name}-app-"
  description = "Security group for the Application tier"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-app-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# checkov:skip=CKV2_AWS_5:Security groups will be attached to compute resources in a future phase.
resource "aws_security_group" "db" {
  name_prefix = "${var.project_name}-db-"
  description = "Security group for the Database tier"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-db-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}
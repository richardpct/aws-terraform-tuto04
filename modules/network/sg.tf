// Rules for DataBase
resource "aws_security_group" "database" {
  name   = "sg_database-${var.env}"
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "database_sg-${var.env}"
  }
}

resource "aws_security_group_rule" "database_inbound_redis" {
  type                     = "ingress"
  from_port                = local.redis_port
  to_port                  = local.redis_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.webserver.id
  security_group_id        = aws_security_group.database.id
}

resource "aws_security_group_rule" "database_outbound_http" {
  type              = "egress"
  from_port         = local.http_port
  to_port           = local.http_port
  protocol          = "tcp"
  cidr_blocks       = local.anywhere
  security_group_id = aws_security_group.database.id
}

resource "aws_security_group_rule" "database_outbound_https" {
  type              = "egress"
  from_port         = local.https_port
  to_port           = local.https_port
  protocol          = "tcp"
  cidr_blocks       = local.anywhere
  security_group_id = aws_security_group.database.id
}

// Rules for WebServer
resource "aws_security_group" "webserver" {
  name   = "sg_webserver-${var.env}"
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "webserver_sg-${var.env}"
  }
}

resource "aws_security_group_rule" "webserver_inbound_ssh" {
  type              = "ingress"
  from_port         = local.ssh_port
  to_port           = local.ssh_port
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_allowed_ssh]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_inbound_http" {
  type              = "ingress"
  from_port         = local.webserver_port
  to_port           = local.webserver_port
  protocol          = "tcp"
  cidr_blocks       = local.anywhere
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_outbound_http" {
  type              = "egress"
  from_port         = local.http_port
  to_port           = local.http_port
  protocol          = "tcp"
  cidr_blocks       = local.anywhere
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_outbound_https" {
  type              = "egress"
  from_port         = local.https_port
  to_port           = local.https_port
  protocol          = "tcp"
  cidr_blocks       = local.anywhere
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_outbound_redis" {
  type                     = "egress"
  from_port                = local.redis_port
  to_port                  = local.redis_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.database.id
  security_group_id        = aws_security_group.webserver.id
}

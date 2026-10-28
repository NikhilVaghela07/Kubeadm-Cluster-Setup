resource "aws_security_group" "sg" {
  name = var.sg_name
  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "incomming" {
  for_each          = toset(var.ports)
  from_port         = each.value
  to_port           = each.value
  security_group_id = aws_security_group.sg.id
  ip_protocol       = var.protocol_incommig
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "outgoing" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = var.ip_protocol_outgooing
}
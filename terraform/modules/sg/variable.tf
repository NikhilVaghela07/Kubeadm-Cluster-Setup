variable "ports" {
  type        = set(string)
  description = "Port for incoming traffic"
}

variable "cidr_ipv4" {
  type = string
  description = "add ipv4 cidr block"
}

variable "protocol_incommig" {
  type = string
  description = "write protocol, like tcp, SSH, HTTP"
}

variable "sg_name" {
  type = string
  description = "Security group name"
}

variable "tags" {
  type = map(string)
  description = "tags for security group"
}

variable "ip_protocol_outgooing" {
  type = string
  description = "ip protocol for outgooing"
}
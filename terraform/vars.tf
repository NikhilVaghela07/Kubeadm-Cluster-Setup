variable "ports" {
  type = list(number)
}

variable "region" {
  type = string
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair to create"
}

variable "private_key_filename" {
  type        = string
  description = "Local path where Terraform saves the generated private key"
}

variable "cidr_ipv4" {
  type = string
}


variable "instance_type" {
  type = string
}

variable "worker_node_count" {
  type = number
}

variable "tags_for_ec2_master" {
  type = map(string)
}

variable "tags_for_ec2_worker" {
  type = map(string)
}

variable "sg_name" {
  type        = string
  description = "Add security name"
}

variable "ip_protocol_outgooing" {
  type        = string
  description = "outbound rule for ec2"
}

variable "protocol_incomming" {
  type        = string
  description = "inbound rule for ec2"
}

variable "tags_for_sg" {
  type        = map(string)
  description = "tags for security group"
}

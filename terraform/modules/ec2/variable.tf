variable "instance_type" {
  type = string
  description = "add instance type"
}

variable "worker_node_count" {
  type = number
  description = "add worker node count, total worker node count"

}

variable "tags_for_ec2_master" {
  type = map(string)
  description = "Tags for EC2 instance"
}

variable "tags_for_ec2_worker" {
  type = map(string)
  description = "Tags for EC2 instance worker node"
}

variable "security_group_id" {
  type = string
  description = "Security group use for incomming and outgooing"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}
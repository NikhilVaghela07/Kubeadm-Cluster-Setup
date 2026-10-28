data "aws_ami" "letest_ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "master_node" {
  ami                    = data.aws_ami.letest_ubuntu.id
  vpc_security_group_ids = [var.security_group_id]
  instance_type          = var.instance_type
  key_name               = var.key_name
  tags = var.tags_for_ec2_master
}

resource "aws_instance" "worker_node" {
  count                  = var.worker_node_count
  ami                    = data.aws_ami.letest_ubuntu.id
  vpc_security_group_ids = [var.security_group_id]
  instance_type          = var.instance_type
  key_name               = var.key_name
  tags = merge(var.tags_for_ec2_worker, {
    Name = "Worker-Node-${count.index + 1}"
  })
}
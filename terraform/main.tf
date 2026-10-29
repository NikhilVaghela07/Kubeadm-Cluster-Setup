terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tls = {
      source = "hashicorp/tls"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region = var.region
}

module "key_pair" {
  source               = "./modules/key_pair"
  key_name             = var.key_name
  private_key_filename = var.private_key_filename
}

module "ec2_instance" {
  source              = "./modules/ec2"
  instance_type       = var.instance_type
  worker_node_count   = var.worker_node_count
  tags_for_ec2_master = var.tags_for_ec2_master
  tags_for_ec2_worker = var.tags_for_ec2_worker
  security_group_id   = module.security_group.security_group_id
  key_name            = module.key_pair.key_name
}

module "security_group" {
  source                = "./modules/sg"
  sg_name               = var.sg_name
  ip_protocol_outgooing = var.ip_protocol_outgooing
  ports                 = var.ports
  cidr_ipv4             = var.cidr_ipv4
  protocol_incommig     = var.protocol_incomming
  tags                  = var.tags_for_sg
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = templatefile("${path.module}/inventory.tftpl", {
    master_ip  = module.ec2_instance.master_public_ip
    worker_ips = module.ec2_instance.worker_public_ip
    key_file   = abspath(var.private_key_filename)
  })
}

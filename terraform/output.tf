output "master_public_ip" {
  value = module.ec2_instance.master_public_ip
}

output "worker_public_ips" {
  value = module.ec2_instance.worker_public_ip
}

output "private_key_openssh" {
  value     = module.key_pair.private_key_openssh
  sensitive = true
}
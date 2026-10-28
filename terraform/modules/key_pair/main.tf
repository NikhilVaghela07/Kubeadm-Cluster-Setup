resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair"{
  key_name = var.key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_sensitive_file" "save_private_key" {
  content = tls_private_key.key.private_key_openssh
  filename = var.private_key_filename
  file_permission = "0600"
}
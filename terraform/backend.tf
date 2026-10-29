terraform {
  backend "s3" {
    bucket = "kuberentes-cluster-kubeadm"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
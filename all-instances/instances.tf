provider "aws" {
    region = "us-east-1"
}

module "all-instances-module" {
    source = "./all-instances-module"
    server_names = ["Jenkins", "maven", "Kubernetes-Jumphost-server"]
}

output "private_ips" {
    value = module.all-instances-module.PrivateIP
}
variable "server_names" {
    type = list(string)
}

resource "aws_instance" "devops_instances" {
    ami = "ami-0b5eea76982371e91"
    key_name = "sosodevops-key"
    instance_type = "t2.micro"
    count = length(var.server_names)
    tags = {
        Name = var.server_names[count.index]
    }
    security_groups = [aws_security_group.sosotech-sec-grp.name]          # SG attachment to EC2 instance
    iam_instance_profile = aws_iam_instance_profile.soso-profile.name     # IAM Role attacgment to EC2 instance
}

output "PrivateIP" {
    value = [aws_instance.devops_instances.*.private_ip]
}


resource "aws_security_group" "sosotech-sec-grp" {
    name = "DevOps instances SG"

    ingress {
        description      = "For HTTPS access"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "10.0.0.0/32","10.0.0.0/16"]
    }

    ingress {
        description      = "For HTTP access"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "10.0.0.0/32","10.0.0.0/16"]
    }

    ingress {
        description      = "For SSH access"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description      = "Jenkins SG"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["10.0.0.0/32","10.0.0.0/16"]
    }
         
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

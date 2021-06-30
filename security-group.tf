resource "aws_security_group" "acesso-ssh-us-east-1" {
    provider = aws.us-east-1
    name = "acesso-ssh-us-east-1"
    description = "Permite acesso via SSH"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        # Please restrict your ingress to only necessary IPs and ports.
        # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
        cidr_blocks = var.cdirs_acesso_remoto
    }

    tags = {
      Name = "ssh"
    }
}

resource "aws_security_group" "acesso-ssh-us-east-2" {
    provider = aws.us-east-2
    name = "acesso-ssh-us-east-2"
    description = "Permite acesso via SSH"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        # Please restrict your ingress to only necessary IPs and ports.
        # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
        cidr_blocks = var.cdirs_acesso_remoto
    }

    tags = {
      Name = "ssh"
    }
}

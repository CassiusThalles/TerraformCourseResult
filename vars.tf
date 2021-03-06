variable "amis" {
    type = map
    default = {
        "us-east-1" = "ami-0747bdcabd34c712a"
        "us-east-2" = "ami-0277b52859bac6f4b"
    }
}

variable "cdirs_acesso_remoto" {
    type = list
    default = ["179.96.162.157/32"]
}

variable "key_name" {
    default = "terraform-aws"
}

variable "instance_type" {
    default = "t2.micro"
}

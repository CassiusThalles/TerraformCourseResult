provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"
}

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
}

terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "cassiustcmendes"
        workspaces {
            name = "cassiusmendes-curso-terraform"
        }
    }

  required_providers {
      aws = {   
          version = "~>2.0"
      }
  }
}

resource "aws_instance" "dev" {
    provider = aws.us-east-1
    count = 3
    ami = var.amis["us-east-1"]
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-east-1.id}" ]
}

# resource "aws_instance" "dev4" {
#     provider = aws.us-east-1
#     ami = var.amis["us-east-1"]
#     instance_type = var.instance_type
#     key_name = var.key_name
#     tags = {
#         Name = "dev4"
#     }
#     vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-east-1.id}" ]
#     depends_on = [
#         aws_s3_bucket.dev4
#     ]
# }

resource "aws_instance" "dev5" {
    provider = aws.us-east-1
    ami = var.amis["us-east-1"]
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev5"
    }
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-east-1.id}" ]
}

resource "aws_instance" "dev6" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev6"
    }
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-east-2.id}" ]
    depends_on = [
        aws_dynamodb_table.dynamodb-homologacao
    ]
}

resource "aws_instance" "dev7" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev7"
    }
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-east-2.id}" ]
}

# resource "aws_s3_bucket" "dev4" {
#     provider = aws.us-east-1
#     bucket = "cassius-terraform-s3-bucket-dev4"
#     acl = "private"

#     tags = {
#         Name = "cassius-terraform-s3-bucket-dev4"
#     }
# }

resource "aws_s3_bucket" "homologacao" {
    provider = aws.us-east-1
    bucket = "cassius-terraform-s3-bucket-homologacao"
    acl = "private"

    tags = {
        Name = "cassius-terraform-s3-bucket-homologacao"
    }
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
    provider = aws.us-east-2
    name = "GameScores"
    billing_mode = "PAY_PER_REQUEST"
    read_capacity = 20
    write_capacity = 20
    hash_key = "UserId"
    range_key = "GameTitle"

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "GameTitle"
        type = "S"
    }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

variable "ami" {
  description = "ID de l'AMI de l'instance EC2"
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_type" {
  description = "value"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

variable "environment" {
  description = "Environnement de déploiement (dev, stage, prod)"
  default     = "dev"
}

# resource "aws_instance" "my_instance" {
#   ami           = var.ami
#   instance_type = "t2.micro"
#   key_name      = "NewKey"  

#   tags = {
#     Name        = "MyEC2Instance"
#     Environment = var.environment
#     instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
#   }
# }

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "tf-example"
  }
}


# output "instance_id" {
#   value = aws_instance.my_instance.id
# }

# output "public_ip" {
#   value = aws_instance.my_instance.public_ip
# }

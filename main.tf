provider "aws" {
  region = "us-east-1"
  access_key= "AKIAZCZSUW45UQ55L3PQ"
  secret_key= "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"
}

resource "aws_instance" "exemple_instance" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = "keyAWS"

  tags = {
    Name = "exemple-instance-terraform"
  }
}

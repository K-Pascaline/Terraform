resource "aws_instance" "example" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3",
      "sudo systemctl start python3",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "NewKey"
      host        = self.public_ip
    }
  }
}

resource "null_resource" "example" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo 'Ceci est une commande locale'"
  }
}


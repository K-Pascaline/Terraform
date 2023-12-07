provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "127.0.0.1:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "role_id"
      secret_id = "secret_id"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "dev/my-app"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}
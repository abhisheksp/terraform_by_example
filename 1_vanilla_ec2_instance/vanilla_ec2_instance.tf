provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "app_server_1" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
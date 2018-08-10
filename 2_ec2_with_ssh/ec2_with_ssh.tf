provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami             = "ami-0d44833027c1a3297"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.example.name}"]
  key_name        = "${aws_key_pair.generated_key.key_name}"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "example_key_pair"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

resource "aws_security_group" "example" {
  name        = "grant ssh"
  description = "grant ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

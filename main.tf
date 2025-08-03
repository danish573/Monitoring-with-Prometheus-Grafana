<<<<<<< HEAD
=======
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

>>>>>>> e482348 (Code Update)
provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "sg" {
  name        = "security_group"
  description = "Allow SSH and HTTP access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
<<<<<<< HEAD
    cidr_blocks = ["0.0.0/0"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> e482348 (Code Update)
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
<<<<<<< HEAD
    cidr_blocks = ["0.0.0/0"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> e482348 (Code Update)
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
<<<<<<< HEAD
    cidr_blocks = ["0.0.0/0"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> e482348 (Code Update)
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
<<<<<<< HEAD
    cidr_blocks = ["0.0.0/0"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> e482348 (Code Update)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
<<<<<<< HEAD
    cidr_blocks = ["0.0.0/0"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> e482348 (Code Update)
  }

}

<<<<<<< HEAD
resource "aws-instance" "prometheus_grafana_instance" {
=======
resource "aws_instance" "prometheus_grafana_instance" {
>>>>>>> e482348 (Code Update)
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.sg.name]
  user_data       = file("setup.sh") # Ensure you have a setup.sh script for initial configuration

  tags = {
    Name = "Prometheus-Grafana-Instance"
  }

}
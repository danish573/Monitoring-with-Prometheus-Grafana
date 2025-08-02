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
    cidr_blocks = ["0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
  }

}

resource "aws-instance" "prometheus_grafana_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.sg.name]
  user_data       = file("setup.sh") # Ensure you have a setup.sh script for initial configuration

  tags = {
    Name = "Prometheus-Grafana-Instance"
  }

}
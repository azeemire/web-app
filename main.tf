provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = "us-east-1"
}
# Create a Security Group
resource "aws_security_group" "server_sg" {
  name        = "server-security-group"
  description = "Allow inbound traffic"

  # Allow SSH (port 22) to connect to the server
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Allows access from anywhere
  }

  # Allow HTTP (port 80) for web traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "server_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc"  
  instance_type = "t2.micro"               # Free-tier instance type
   key_name      = "my-ec2-key"

  security_groups = [aws_security_group.server_sg.name]

  tags = {
    Name = "MyServer"
  }
}

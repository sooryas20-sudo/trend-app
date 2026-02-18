provider "aws" {
  region = "ap-south-1" 
}

# 1. Get the latest Ubuntu AMI automatically
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Updated Security Group (Includes Jenkins & Monitoring Ports)
resource "aws_security_group" "trend_app_sg" {
  name        = "trend-app-sg"
  description = "Allow SSH, HTTP, Jenkins, and Monitoring"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3000 for Grafana Dashboard
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9090 for Prometheus
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 8080 for Jenkins Server (Crucial for rework)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Create the EC2 Instance with Automated Jenkins Install
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = "trend-key"

  vpc_security_group_ids = [aws_security_group.trend_app_sg.id]

  tags = {
    Name = "Trend-App-Server"
  }

  # UPDATED: Added Jenkins and Java 17 installation to user_data
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io git fontconfig openjdk-17-jre
              
              # Jenkins Installation
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt update -y
              sudo apt install -y jenkins
              
              # Start Services
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Permissions
              sudo usermod -aG docker ubuntu
              sudo usermod -aG docker jenkins
              EOF
}

output "server_public_ip" {
  value = aws_instance.web.public_ip
}

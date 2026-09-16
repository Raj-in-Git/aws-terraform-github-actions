data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "web" {
  ami = data.aws_ssm_parameter.amazon_linux.value

  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y nginx

              systemctl enable nginx
              systemctl start nginx

              cat > /usr/share/nginx/html/index.html <<HTML
              <!DOCTYPE html>
              <html>
              <head>
                <title>GUVI Terraform Project</title>
              </head>
              <body>
                <h1>AWS Infrastructure Created Using Terraform</h1>
                <p>EC2 + VPC + S3 + IAM + GitHub Actions</p>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name      = "${var.project_name}-web-server"
    ManagedBy = "Terraform"
  }
}

resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name      = "${var.project_name}-eip"
    ManagedBy = "Terraform"
  }
}

resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
}
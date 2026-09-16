output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public_2.id
}

output "security_group_id" {
  description = "EC2 Security Group ID"
  value       = aws_security_group.ec2.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.web.public_ip
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.project.bucket
}

output "iam_role_name" {
  description = "IAM Role name"
  value       = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  description = "EC2 Instance Profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "website_url" {
  description = "Nginx website URL"
  value       = "http://${aws_eip.web.public_ip}"
}
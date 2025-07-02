output "ec2_instance_id" {
  value = aws_instance.threat_target.id
}

output "ec2_public_ip" {
  value = aws_instance.threat_target.public_ip
}

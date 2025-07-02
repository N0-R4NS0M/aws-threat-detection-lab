variable "aws_region" {
  default = "us-west-2"
}

variable "ec2_ami" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI for us-west-2
}

variable "ssh_key_name" {
  description = "Name of your existing EC2 key pair"
}

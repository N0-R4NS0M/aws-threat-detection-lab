variable "aws_region" {
  default = "us-west-2"
}

variable "ec2_ami" {
  default = "ami-08bfb3ff75119bd97"
}

variable "ssh_key_name" {
  description = "Your EC2 key pair name"
  default     = "my-keypair"
}

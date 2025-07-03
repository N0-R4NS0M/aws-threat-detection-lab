variable "aws_region" {
  default = "us-west-2"
}

variable "ec2_ami" {
  default = "ami-0c02fb55956c7d316"
}

variable "ssh_key_name" {
  description = "Your EC2 key pair name"
  default     = "my-keypair"
}

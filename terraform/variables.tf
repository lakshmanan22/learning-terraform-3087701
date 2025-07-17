variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  default     = "ami-0a1235697f4afa8a4" # Amazon Linux 2 in mumbai
}

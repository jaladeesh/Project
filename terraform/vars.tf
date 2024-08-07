variable "aws_region" {
  description = "To create 3 instances in mentioned region"
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "AMI ID for instances"
  default     = "ami-0497a974f8d5dcef8" 
}

variable "instance_type" {
  description = "instance type"
  default     = "t2.medium"
}

variable "availability_zone" {
  description = "availability zone for subnet"
  default     = "ap-southeast-1a"
}

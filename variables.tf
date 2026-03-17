variable "aws_region" {
description = "AWS region to deploy resources"
type = string
default = "us-east-1"
}
variable "vpc_cidr" {
description = "CIDR block for the VPC"
type = string
default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
description = "CIDR block for the public subnet"
type = string
default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
description = "CIDR block for the private subnet"
type = string
default = "10.0.2.0/24"
}
variable "public_subnet_cidr_2" {
description = "CIDR block for second public subnet (ALB needs 2 AZs)"
type = string
default = "10.0.3.0/24"
}
variable "key_name" {
description = "Name of the SSH key pair"
type = string
}
variable "my_ip" {
description = "Your public IP for SSH access (e.g., 203.0.113.50/32)"
type = string
}
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS Account Profile"
  default     = "duggan-xyz-admin"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
  default     = "10.10.0.0/16"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnames"
  default     = true
}

variable "vpc_subnets_cidr_blocks" {
  type        = list(string)
  description = "CIDR for Subnets in VPC"
  default     = ["10.10.0.0/24", "10.10.10.0/24","10.10.20.0/24"]
}

variable "route_table" {
  type        = string
  description = "Route Table Values"
  default     = "0.0.0.0/0"
}

variable "sg_ingress" {
  type        = string
  description = "Ingress Locations"
  default     = "37.228.249.190/32"
}

variable "ec2_instance" {
  type        = string
  description = "EC2 Instance Types"
  default     = "t2.micro"
}

variable "group" {
  type       = string
  description = "Group for Ansible Dynamic Inventory"
  default     = "nginx"
}

variable "win_ec2_instance" {
  type        = string
  description = "EC2 Instance Types"
  default     = "t3.small"
}

variable "company" {
  type        = string
  description = "Company Name"
  default     = "BlackAlder"
}

variable "project" {
  type        = string
  description = "Project Name"
  default     = "Inquire"
}

variable "billing_code" {
  type        = string
  description = "Project Billing Code"
  default     = "IPD01"
}

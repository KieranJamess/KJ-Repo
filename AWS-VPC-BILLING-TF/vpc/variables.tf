variable "name" {
  default     = "Default"
  type        = string
  description = "Name of the VPC"
}

variable "region" {
  default     = "eu-west-2"
  type        = string
  description = "Region of the VPC"
}

#variable "key_name" {
#  type        = string
#  description = "EC2 Key pair name for the bastion"
#}

variable "cidr_block" {
  default     = "10.100.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.100.1.0/24", "10.100.3.0/24", "10.100.5.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.100.2.0/24", "10.100.4.0/24", "10.100.6.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  type        = list
  description = "List of availability zones"
}

#variable "bastion_ami" {
#  type        = string
#  description = "Bastion Amazon Machine Image (AMI) ID"
#}

#variable "bastion_ebs_optimized" {
#  default     = false
#  type        = bool
#  description = "If true, the bastion instance will be EBS-optimized"
#}

#variable "bastion_instance_type" {
#  default     = "t3.nano"
#  type        = string
#  description = "Instance type for bastion instance"
#}

variable "ami" {
  type    = string
  default = "ami-0389b2a3c4948b1a0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

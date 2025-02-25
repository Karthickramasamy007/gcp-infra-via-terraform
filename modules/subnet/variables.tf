variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for associating the subnet"
  type        = string
}

variable "region" {
  description = "Region where the subnet will be created"
  type        = string
}

variable "cidr_range" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

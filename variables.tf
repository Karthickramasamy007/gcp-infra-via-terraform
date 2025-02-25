variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Region where the resources will be provisioned"
  type        = string
}

variable "zone" {
  description = "Zone where the resources will be provisioned"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "image" {
  description = "Image for the VM"
  type        = string
}

variable "vm_tags" {
  description = "Tags for the VM"
  type        = list(string)
}

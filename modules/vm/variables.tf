variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "zone" {
  description = "Zone where the VM will be created"
  type        = string
}

variable "image" {
  description = "Image for the VM (e.g., ubuntu-20-04)"
  type        = string
}

variable "network" {
  description = "VPC network for the VM"
  type        = string
}

variable "subnet" {
  description = "Subnetwork for the VM"
  type        = string
}

variable "vm_tags" {
  description = "Tags for the VM"
  type        = list(string)
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source    = "./modules/vpc"
  vpc_name  = var.vpc_name
  project_id = var.project_id
}

module "subnet" {
  source     = "./modules/subnet"
  subnet_name = var.subnet_name
  vpc_id      = module.vpc.vpc_id
  region      = var.region
  cidr_range  = var.subnet_cidr
  project_id  = var.project_id
}

/*module "vm" {
  source       = "./modules/vm"
  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  image        = var.image
  network      = module.vpc.vpc_id
  subnet       = module.subnet.subnet_id
  vm_tags      = var.vm_tags
  project_id   = var.project_id
}*/

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.subnet.subnet_id
}

/*output "vm_id" {
  value = module.vm.vm_id
}*/


# GCP bucket as Terraform state backend
/*terraform {
  backend "gcs" {
    bucket  = "tf-state-karthick"
    prefix  = "terraform/env/state"
  }
}*/

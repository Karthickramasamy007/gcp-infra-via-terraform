resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = var.vpc_id
  ip_cidr_range = var.cidr_range
  project       = var.project_id
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}
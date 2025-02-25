resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks  = false
  project                 = var.project_id
}

output "vpc_id" {
  value = google_compute_network.vpc.id
}

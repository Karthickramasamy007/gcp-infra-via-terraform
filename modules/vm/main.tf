resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnet
    access_config {
      // Assign an external IP address
    }
  }

  tags = var.vm_tags
}

output "vm_id" {
  value = google_compute_instance.vm.id
}

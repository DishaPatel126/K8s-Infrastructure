provider "google" {
  project = "disha-k8s-project"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "disha-gke-cluster"
  location = "us-central1"
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_compute_disk" "pv_disk" {
  name  = "disha-pv-disk"
  type  = "pd-standard"
  zone  = "us-central1-a"
  size  = 1
}

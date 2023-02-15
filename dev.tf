provider "google" {
    region = var.zone
    zone = var.zone
    project = var.project_id
}

resource "google_container_cluster" "vik-prod-cluster" {
  name     = "vik-prod-cluster"
  location = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network = google_compute_network.vpc.self_link
  subnetwork =  google_compute_subnetwork.subnet-europe-west4.self_link
  
}

resource "google_container_node_pool" "prod-node-pool" {
  name       = "prod-node-pool"
  cluster    = google_container_cluster.vik-prod-cluster.name
  node_count = 1
  location = var.zone

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    
  }
      
  }

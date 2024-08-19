#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# resource "google_service_account" "time-api" {
#   project      = "supple-defender-349711"
#   account_id = "time-api"
# }
resource "google_service_account" "time-api2" {
  account_id   = "time-api2"
  display_name = "Time API2 Service Account"
  project      = "supple-defender-349711"
}


resource "google_project_iam_member" "kubernetes_engine_admin" {
  project      = "supple-defender-349711"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.time-api2.email}"
}

resource "google_project_iam_member" "kubernetes_engine_cluster_viewer" {
  project      = "supple-defender-349711"
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.time-api2.email}"
}

resource "google_project_iam_member" "service_account_user" {
  project      = "supple-defender-349711"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.time-api2.email}"
}

resource "google_project_iam_member" "storage_object_viewer" {
  project      = "supple-defender-349711"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.time-api2.email}"
}




# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = google_service_account.time-api2.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name    = "spot"
  cluster = google_container_cluster.primary.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    labels = {
      team = "devops"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.time-api2.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

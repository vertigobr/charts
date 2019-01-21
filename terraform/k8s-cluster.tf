
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_domain" "my-domain" {
  name       = "apps-dev.vertigo.com.br"
}

resource "digitalocean_kubernetes_cluster" "my-cluster" {
  name    = "apps-dev"
  region  = "nyc1"
  version = "1.13.1-do.2"
  tags    = ["vtg-apps-dev"]

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }
}

provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.my-cluster.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.my-cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.my-cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.my-cluster.kube_config.0.cluster_ca_certificate)}"
}

output "my-kubeconfig" {
  value = "${digitalocean_kubernetes_cluster.my-cluster.kube_config.0.raw_config}"
#  value = "${digitalocean_kubernetes_cluster.my-cluster.endpoint}"
}


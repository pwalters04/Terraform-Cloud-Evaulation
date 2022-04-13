locals {
  cluster_name = "demo-eks-cluster"
}
module "eks_cluster" {
  source = "../modules/services/eks/"
  name = local.cluster_name

  max_size = 2
  min_size = 1
  desired_size = 1
  instance_type = ["t3.small"]
  region = var.region
}

resource "time_sleep" "wait_200_secs" {
  depends_on = [module.eks_cluster.cluster_name]
  create_duration = "200s"
}

resource "null_resource" "config" {
  triggers = {
    always = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<EOT
      set -e
      echo 'Applying Auth ConfigMap with kubectl...'
      aws eks wait cluster-active --name '${local.cluster_name}'
      aws eks update-kubeconfig --name '${local.cluster_name}' --alias '${local.cluster_name}-${var.region}' --region=${var.region}
    EOT
  }
  depends_on = [module.eks_cluster,time_sleep.wait_200_secs]
}

module "simple_webapp" {
  source = "../modules/services/k8s-app"
  image = "training/webapp"
  name = "simple-webapp"

  container_port = 5000
  replicas = 2

  env_vars = {
    PROVIDER = "Terraform"
  }

  depends_on = [module.eks_cluster]
}

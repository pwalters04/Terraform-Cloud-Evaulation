module "eks_cluster" {
  source = "../modules/services/eks/"
  name = "demo-eks-cluster"

  max_size = 1
  min_size = 2
  desired_size = 1
  instance_type = ["t3.small"]
  region = var.region
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

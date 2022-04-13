provider "kubernetes" {
  host = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_cert_auth[0].data)
  token = data.aws_eks_cluster_auth.cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "update-kubeconfig",
      "--cluster-name",
      "wait cluster-active",
      "--name",
      "--alias",
      "--region=",
      module.eks_cluster.cluster_name
    ]
  }
}

data "aws_eks_cluster_auth" "cluster"{
  name = module.eks_cluster.cluster_name
}

provider "aws" {
  region = var.region
}

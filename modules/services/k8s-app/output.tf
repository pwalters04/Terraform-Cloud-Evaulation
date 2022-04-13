locals{
 status = kubernetes_service.app.status
}

output "service_endpoint" {
  value = try(
            "https://${local.status[0]["load_balance"][0]["ingress"][0]["hostname"]}",
            "(eror parising hostname from status)"
  )
  description = " K8S Service endpoint"
}
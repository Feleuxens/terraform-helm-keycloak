resource "helm_release" "keycloak" {
  name = "keycloak"

  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "keycloak"
  version          = "24.0.1"
  create_namespace = true
  namespace        = "keycloak"

  values = [
    templatefile("${path.module}/helm-values/keycloak.yaml", {
      domain : var.domain,
      admin_user : var.admin_user
      http_relative_path : var.http_relative_path
      replica_count : var.replica_count
      cpu_request : var.cpu_request
      memory_request : var.memory_request
      memory_limit : var.memory_limit
      enable_autoscaling : var.enable_autoscaling
      enable_metrics : var.enable_metrics
      enable_service_monitor : var.enable_service_monitor
      enable_prometheus_rule : var.enable_prometheus_rule
      prometheus_namespace : var.prometheus_namespace
      keycloak_logging_level : var.keycloak_logging_level
    })
  ]
  set_sensitive {
    name  = "auth.adminPassword"
    value = var.keycloak_admin_password
  }
  set_sensitive {
    name  = "postgres.auth.postgresPassword"
    value = var.postgres_admin_password
  }
  set_sensitive {
    name  = "postgres.auth.password"
    value = var.postgres_user_password
  }
}

# ingress that redirect everything from id.${domain} to id.${domain}realms/users/account
resource "kubernetes_ingress_v1" "redirect_ingress" {
  metadata {
    name      = "redirect-ingress"
    namespace = helm_release.keycloak.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/permanent-redirect" = "https://id.${var.domain}/realms/users/account"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "id.${var.domain}"
      http {
        path {
          backend {
            service {
              name = "keycloak"
              port {
                name = "http"
              }
            }
          }
          path      = "/"
          path_type = "Exact"
        }
      }
    }
  }
}
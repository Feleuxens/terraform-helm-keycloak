variable "domain" {
  description = "Domain name"
  type        = string
}

variable "admin_user" {
  default     = "admin"
  type        = string
  description = "Keycloak Admin Username"
}

variable "http_relative_path" {
  default     = "/"
  type        = string
  description = "HTTP relative path prefix"
}

variable "replica_count" {
  default = 1
  type    = number
}

variable "cpu_request" {
  default = "10m"
  type    = string
}

variable "memory_request" {
  default = "100Mi"
  type    = string
}

variable "memory_limit" {
  default = "500Mi"
  type    = string
}

variable "enable_autoscaling" {
  default = false
  type    = bool
}

variable "enable_metrics" {
  default = false
  type    = bool
}

variable "enable_service_monitor" {
  default = false
  type    = bool
}

variable "enable_prometheus_rule" {
  default     = false
  type        = bool
  description = "Create PrometheusRule Resource for scraping metrics using Prometheus Operator"
}

variable "prometheus_namespace" {
  default     = ""
  type        = string
  description = "Namespace where Prometheus is running in. Needed when using Prometheus Operator"
}

variable "keycloak_admin_password" {
  type        = string
  description = "Keycloak Admin Password"
}

variable "postgres_admin_password" {
  type        = string
  description = "Postgres admin password"
}

variable "postgres_user_password" {
  type        = string
  description = "Postgres user password"
}

variable "keycloak_logging_level" {
  default     = "INFO"
  type        = string
  description = "Logging level: FATAL, ERROR, WARN, INFO, DEBUG, TRACE, ALL, OFF"
}
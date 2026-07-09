# outputs.tf
# Values exposed after apply — useful for CI/CD, DNS setup, or monitoring configs.

output "vpc_id" {
  description = "Production VPC ID"
  value       = module.network.vpc_id
}

output "load_balancer_dns" {
  description = "Public DNS of the production load balancer"
  value       = module.compute.lb_dns_name
}

output "db_endpoint" {
  description = "Production database endpoint"
  value       = module.database.endpoint
  sensitive   = true
}

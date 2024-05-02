# Application Load Balancer
output "mage_load_balancer" {
  description = "The name of the application load balancer for Mage AI."
  value = aws_alb.application_load_balancer.name
}

# Applicaton Load Balancer 
output "load_balancer_dns_name" {
  description = "The DNS name for the application load balancer."
  value = aws_alb.application_load_balancer.dns_name
}
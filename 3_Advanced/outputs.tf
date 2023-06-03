output "app_id" {
  description = "ID of the EC2 instances"
  value       = [for app in aws_instance.app_server : app.id]
}

output "app_public_ip" {
  description = "Public IP address of the EC2 instances"
  value       = [for app in aws_instance.app_server : app.public_ip]
}

output "api_id" {
  description = "ID of the EC2 instances"
  value       = [for api in aws_instance.api_server : api.id]
}

output "api_public_ip" {
  description = "Public IP address of the EC2 instances"
  value       = [for api in aws_instance.api_server : api.public_ip]
}

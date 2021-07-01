output "id" {
  description = "The Security Group ID"
  value       = try(one(aws_security_group._.*.id), null)
}

output "arn" {
  description = "The Security Group ARN"
  value       = try(one(aws_security_group._.*.arn), null)
}

output "name" {
  description = "The Security Group Name"
  value       = try(var.name, null)
}
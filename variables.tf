variable "vpc_id" {
  type        = string
  description = "The VPC ID where Security Group will be created."
}

variable "security_group_enabled" {
  type        = bool
  default     = true
  description = "Whether to create Security Group."
}

variable "description" {
  type        = string
  default     = "VPC Security Group"
  description = "The Security Group description."
}

variable "rules" {
  type = list(object({
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    ipv6_cidr_blocks         = list(string)
    security_group_id        = string
    prefix_list_ids          = list(string)
    self                     = bool
    source_security_group_id = string
  }))
  default     = null
  description = "Provides a security group rule resource. Represents a single ingress or egress group rule, which can be added to external Security Groups"
}

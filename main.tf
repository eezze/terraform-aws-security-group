locals {
  tags = {
    Environment = var.environment
    Name        = var.name
  }
}

resource "aws_security_group" "_" {
  count = var.security_group_enabled

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "_" {
  for_each = var.rules

  security_group_id = one(aws_security_group._.*.id)
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  description       = each.value.description
  # Convert any of a missing key, a value of null, or a value of empty list to null
  cidr_blocks      = try(length(lookup(each.value, "cidr_blocks", [])), 0) > 0 ? each.value["cidr_blocks"] : null
  ipv6_cidr_blocks = try(length(lookup(each.value, "ipv6_cidr_blocks", [])), 0) > 0 ? each.value["ipv6_cidr_blocks"] : null
  prefix_list_ids  = try(length(lookup(each.value, "prefix_list_ids", [])), 0) > 0 ? each.value["prefix_list_ids"] : null
  self             = coalesce(lookup(each.value, "self", null), false) ? true : null

  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

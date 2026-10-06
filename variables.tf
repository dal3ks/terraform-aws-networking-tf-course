# Migrating to object variables: 
# refactored individual primitive variables such as vpc_cidr_block and vpc_name into a single object.
# makes module easier to organise as it grows 
variable "vpc_config" {
  description = "Contains VPC configuration options such as the CIDR block and VPC name."

  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block."

  }
}

variable "subnet_config" {
  description = <<EOT
  Accepts map of subnet configurations. Each subnet configuration should contain
  cidr_block : The CIDR block for the subnet.
  public : Whether the subnet is public or private. Defaults to false (private).
  az : The availability zone where to deploy the subnet.
  EOT
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The cidr_block config option must contain a valid CIDR block."

  }
}
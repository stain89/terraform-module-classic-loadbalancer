variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID in which Security Group will be provisioned"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where Security Group will be provisioned"
}

variable "subnet_type" {
  type        = string
  default     = "Public"
  description = "Subnet type. Either Private or Public."
}

variable "name" {
  type        = string
  default     = "test"
  description = "Name of product to which resource belongs to"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Environment resource belong to. Ex Dev/Test/Prod"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the ELB"
}

variable "internal" {
  default     = false
  description = "If true, ELB will be an internal ELB"
  type        = bool
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  type        = bool
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  type        = number
  default     = 300
}

variable "access_logs" {
  description = "An access logs block"
  type        = map(string)
  default     = {}
}

variable "health_check" {
  description = "A health check block"
  type        = map(string)
  default = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

variable "listener" {
  description = "A list of listener blocks"
  type        = list(map(string))
  default = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
  ]
}
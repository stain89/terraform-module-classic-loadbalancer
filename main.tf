# Provider
provider "aws" {
  region = var.aws_region
}

# List of Subnets to attach to ELB
data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id

  tags {
    Zone = var.subnet_type
  }

  depends_on = [
  null_resource.force_dependencies]
}

# Classic Load Balancer
resource "aws_elb" "elb" {
  name = "${var.name}-clb"
  subnets = [
  data.aws_subnet_ids.subnets.ids]
  internal = var.internal
  security_groups = [
  var.security_groups_ids]
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  # Setting Listeners for ELB
  dynamic "listener" {
    for_each = var.listener
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }

  # Health Check
  health_check {
    healthy_threshold   = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    target              = lookup(var.health_check, "target")
    interval            = lookup(var.health_check, "interval")
    timeout             = lookup(var.health_check, "timeout")
  }
}


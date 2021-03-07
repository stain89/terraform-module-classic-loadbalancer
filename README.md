### Generic Classic Load Balancer Terraform Module

#### Example usage

```
module "my-elb" {
 # version = "~>12"
  source      = "git@github.com:stain89/terraform-module-classic-loadbalancer.git"
  vpc_id      = "vpc-a27e94ea"
  name        = "test"
  environment = "dev"
  aws_region  = "eu-central-1"
  security_groups_ids = ["sg-0aab0a0045e7rbd1e"]
  subnet_type         = "public"
  
  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
    {
      instance_port     = "8080"
      instance_protocol = "http"
      lb_port           = "8080"
      lb_protocol       = "http"
      ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
    },
  ]
 
 health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}
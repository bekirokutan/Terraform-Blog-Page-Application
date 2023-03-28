resource "aws_lb" "test" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.tf-public-1a.id, aws_subnet.tf-public-1b.id]
}

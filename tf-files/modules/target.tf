resource "aws_lb_target_group" "test" {
  name     = "target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.capstone-vpc-tf.id
}
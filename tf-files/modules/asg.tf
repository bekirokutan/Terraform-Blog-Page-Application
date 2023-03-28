resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.tf-private-1a.id, aws_subnet.tf-private-1b.id]
  force_delete              = true
  launch_template {
    name    = aws_launch_template.launch.name
    version = "$Latest"
  }
  target_group_arns = ["${aws_lb_target_group.test.arn}"]
}
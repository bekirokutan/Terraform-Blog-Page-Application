resource "aws_launch_template" "launch" {
  depends_on = [
    aws_db_instance.capstone_rds,
    github_repository_file.dbendpoint
  ]
  name_prefix            = "launch"
  image_id               = var.imageid
  instance_type          = "t2.micro"
  key_name               = var.keyname
  vpc_security_group_ids = ["${aws_security_group.ec2.id}"]
  user_data              = base64encode(data.template_file.terrablog.rendered)
  iam_instance_profile {
    name = aws_iam_instance_profile.instance-role.name
  }
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["amazon"] # Canonical
# }





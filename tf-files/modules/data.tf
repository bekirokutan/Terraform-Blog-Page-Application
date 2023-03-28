data "template_file" "terrablog" {
  template = "${file("${path.module}/userdata.sh")}"
  vars = {
    userdata-git-user = var.git-user-name
    userdata-git-repo = var.git-repo-name
  }
}
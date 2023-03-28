data "template_file" "phonebook" {
  template = "${file("${path.module}/userdata.sh")}"
  vars = {
    userdata-git-user = var.git-user-name
    userdata-git-repo = var.git-repo-name
  }
}
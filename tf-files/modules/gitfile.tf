resource "github_repository_file" "dbendpoint" {
  content             = aws_db_instance.capstone_rds.address
  file                = var.endpointpath
  repository          = var.repositoryname
  overwrite_on_create = true
  branch              = "main"
  depends_on = [
    aws_db_instance.capstone_rds
  ]
}
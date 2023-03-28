module "phonebook" {
  source = "../modules"
  dataname = "database1" #settings.py de aynı database name olmalı
  datauser = "admin" #settings.py de aynı username olmalı
  datapass = "Bekirdev1234" #.env dosyasında de aynı password olmalı
  s3_bucket_name_blog = "bekirblog" #settings.py de aynı bucketname olmalı
  keyname = "first-key"
  hostname = "bekirokutan.com"
  subdomain_name = "blog.bekirokutan.com"
  repositoryname = "Terraform-Blog-Page-Application"
  endpointpath = "src/dbserver.endpoint"  #settings.py de aynı path olmalı
  imageid= "ami-0e472ba40eb589f49" #ubuntu image 18.04
  git-user-name = "bekirokutan"
  git-repo-name = "Terraform-Blog-Page-Application"
  gittoken = "xxxxxxxxxxxxxxxxxxxxxxx"
}

terraform {
  backend "s3" {}
}

module "webserver" {
  source = "../../../modules/webserver"

  region                       = "eu-west-3"
  env                          = "dev"
  network_remote_state_bucket  = var.bucket
  network_remote_state_key     = var.dev_network_key
  database_remote_state_bucket = var.bucket
  database_remote_state_key    = var.dev_database_key
  instance_type                = "t2.micro"
  image_id                     = "ami-0ebc281c20e89ba4b"  // Amazon Linux 2018
  ssh_public_key               = var.ssh_public_key
  database_pass                = var.dev_database_pass
}

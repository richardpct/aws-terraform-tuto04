provider "aws" {
  region = var.region
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.network_remote_state_bucket
    key    = var.network_remote_state_key
    region = var.region
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")

  vars = {
    database_pass = var.database_pass
  }
}

resource "aws_instance" "database" {
  ami                    = var.image_id
  user_data              = data.template_file.user_data.rendered
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.network.outputs.subnet_private_id
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.sg_database_id]

  tags = {
    Name = "database_server-${var.env}"
  }
}

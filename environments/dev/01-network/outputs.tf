output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_public_id" {
  value = module.network.subnet_public_id
}

output "subnet_private_id" {
  value = module.network.subnet_private_id
}

output "sg_database_id" {
  value = module.network.sg_database_id
}

output "sg_webserver_id" {
  value = module.network.sg_webserver_id
}

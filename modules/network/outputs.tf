output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_public_id" {
  value = aws_subnet.public.id
}

output "subnet_private_id" {
  value = aws_subnet.private.id
}

output "sg_database_id" {
  value = aws_security_group.database.id
}

output "sg_webserver_id" {
  value = aws_security_group.webserver.id
}

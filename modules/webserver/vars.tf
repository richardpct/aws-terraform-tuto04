variable "region" {
  description = "region"
}

variable "env" {
  description = "environment"
}

variable "network_remote_state_bucket" {
  description = "bucket"
}

variable "network_remote_state_key" {
  description = "network key"
}

variable "database_remote_state_bucket" {
  description = "bucket"
}

variable "database_remote_state_key" {
  description = "database key"
}

variable "image_id" {
  description = "image id"
}

variable "instance_type" {
  description = "instance type"
}

variable "ssh_public_key" {
  description = "ssh public key"
}

variable "database_pass" {
  description = "redis password"
}

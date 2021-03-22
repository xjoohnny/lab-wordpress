variable "pvt_key" {
  type = string
  default = "~/.ssh/id_rsa"
}

variable "pub_key" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "gcp_key" {
  type = string
  default = "~/gcp.json"
}

variable "project_name" {
  type = string
  default = "lab-wordpress-cloud"
}

variable "region" {
  type = string
  default = "us-west1"
}

variable "region_zone" {
  type = string
  default = "us-west1-a"
}

variable "fw_name" {
  type = string
  default = "lab-wordpress-fw"
}

variable "instance_name" {
  type = string
  default = "lab-wordpress"
}

variable "instance_type" {
  type = string
  default = "e2-small"
}

variable "image" {
  type = string
  default = "ubuntu-1804-bionic-v20210315a"
}
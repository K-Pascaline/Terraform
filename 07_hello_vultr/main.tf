terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

provider "vultr" {
  api_key = "XVIEVJCOWIWP2N4XGLZXMFKDXZKUG2QXCFVA"
}

resource "vultr_instance" "ma_vm" {
  region    = "fra"
  plan      = "vc2-1c-1gb"
  os_id     = "387"
}

variable "vultr_api_key" {
    description   = "Vultr API token"
    type          = string
}

variable "vultr_instance_os_id" {
    description   = "Vultr OS"
    type          = string
}

variable "vultr_instance_plan" {
    description   = "Vultr Plan"
    type          = string
}

variable "vultr_instance_region" {
    description   = "Vultr Region"
    type          = string
}
variable "instance_user" {
  description = "user name"
  default = "vultr"
}
variable "instance_count" {
  description = "instances to create"
  default = "1"
}

resource "vultr_instance" "my_instance" {
    plan    = var.vultr_instance_plan
    region  = var.vultr_instance_region
    os_id   = var.vultr_instance_os_id 
}

output "instance_user" {
  description = "user login" 
  value = var.instance_user
}
output "instance_ip" {
  value = vultr_instance.my_instance.main_ip
}

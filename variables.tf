###############################
# Azure Authentication
###############################

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type      = string
  sensitive = true
}

###############################
# Backend State (AKS Dev)
###############################

variable "workload_state_rg" {
  type = string
}

variable "workload_state_sa" {
  type = string
}

variable "workload_state_container" {
  type = string
}

variable "workload_state_key" {
  type = string
}

###############################
# Landing Zone Remote State
###############################

variable "lz_state_rg" {
  type = string
}

variable "lz_state_sa" {
  type = string
}

variable "lz_state_container" {
  type = string
}

variable "lz_state_key" {
  type = string
}

###############################
# AKS Cluster Configuration
###############################

variable "aks_resource_group" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = ""
}

variable "environment" {
  type = string
}

variable "aks_node_count" {
  type    = number
  default = 2
}

variable "aks_node_vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "tags" {
  type = map(string)
}
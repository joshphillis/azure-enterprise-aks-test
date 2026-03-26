resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.aks_resource_group
  dns_prefix          = var.dns_prefix

  lifecycle {
    ignore_changes = [
      kubernetes_version
    ]
  }

  default_node_pool {
    name                 = "system"
    node_count           = var.aks_node_count
    vm_size              = var.aks_node_vm_size
    vnet_subnet_id       = local.aks_subnet_id
    orchestrator_version = var.kubernetes_version != "" ? var.kubernetes_version : null
  }

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    service_cidr        = "10.1.0.0/16"
    dns_service_ip      = "10.1.0.10"
    pod_cidr            = "10.244.0.0/16"
    outbound_type       = "userDefinedRouting"
  }

  tags = merge(
    var.tags,
    {
      environment = var.environment
      workload    = "aks"
    }
  )

  depends_on = [data.terraform_remote_state.landing_zone]

  timeouts {
    create = "30m"
    delete = "30m"
  }
}
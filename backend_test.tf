terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-aks-test"
    storage_account_name = "sttfstateakstest01"
    container_name       = "tfstate"
    key                  = "aks-workload-test.tfstate"
  }
}
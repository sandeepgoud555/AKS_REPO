terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
 backend "azurerm" {
    resource_group_name = "aksclusterrg"
    storage_account_name = "sanstorage54"
    container_name = "san"
    key = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "san_aks_rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "san_aks" {
  name                = var.azurerm_kubernetes_cluster
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "san-aks"
  depends_on = [azurerm_resource_group.san_aks_rg]

  default_node_pool {
    name       = "sanpool"
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "990b7bfc-6f00-48b1-941e-58476eeaf976"
    client_secret = "iJO8Q~yxUiuOuM1uRUq3ZYQWb1Mh9ifh3fRhicAw"
  }
}


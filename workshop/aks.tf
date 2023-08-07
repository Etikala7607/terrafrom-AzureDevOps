provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "my-resource-group"
  location = "East US"  # Replace with your desired Azure region
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "my-aks-cluster"

  kubernetes_version  = "1.26.3"  # Replace with your desired Kubernetes version

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId  # Replace with your service principal client ID
    client_secret = var.password  # Replace with your service principal client secret
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}



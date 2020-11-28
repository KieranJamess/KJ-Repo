resource "azurerm_resource_group" "test"{
    name = "test"
    location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = var.clustername
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  dns_prefix          = var.dnspreffix
  default_node_pool {
    name       = "default"
    node_count = var.agentnode
    vm_size    = var.size
  }
  identity {
  type = "SystemAssigned"
  }
}

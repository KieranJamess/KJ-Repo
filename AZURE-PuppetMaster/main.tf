resource "azurerm_resource_group" "puppet" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.puppet.location
  resource_group_name = azurerm_resource_group.puppet.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.puppet.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "publicip" {
  name = "publicip"
  location = var.location
  resource_group_name = azurerm_resource_group.puppet.name
  allocation_method = "Static"
  sku = "Basic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.puppet.location
  resource_group_name = azurerm_resource_group.puppet.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.puppet.location
  resource_group_name   = azurerm_resource_group.puppet.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "${var.vmsize}"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "${var.vmsku}-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine_extension" "puppet" {
  name                 = "puppet"
  virtual_machine_id   = "${azurerm_virtual_machine.main.id}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("files/setup_puppet.sh", {
          git_url="${var.git_url}"
          git_pub_key="${var.git_pub_key}"
          git_pri_key="${var.git_pri_key}"
          email="${var.email}"
          eyaml_pri_key="${var.eyaml_pri_key}"
          eyaml_pub_key="${var.eyaml_pub_key}"
          deployment_user_password="${var.deployment_user_password}"
          server_version="${var.vmsku}"
        }))}"
    }
SETTINGS
}

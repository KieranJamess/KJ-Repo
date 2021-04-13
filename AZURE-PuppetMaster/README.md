## Directions

This creates a VM in azure to host a puppet master. This configuration creates a internal subnet for use but you can switch this out if you don't need to create a new subnet. 

The default configuration uses Ubuntu 1804 and uses the latest version of Puppet Enterprise for Ubuntu 1804.

If you want to use this without linking any github repos or creating any eyaml configurion, you can use the basic setup file. 

You'll need to have generated a public / private key that has access to your puppet control github repo that you're using.

You'll also need to have generated some eyaml keys - the guide can be found [here](https://github.com/voxpupuli/hiera-eyaml). 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.publicip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.puppet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_machine_extension.puppet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | n/a | `string` | `"KieranTest1"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `string` | `"kierantest"` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | n/a | `string` | `"puppet"` | no |
| <a name="input_deployment_user_password"></a> [deployment\_user\_password](#input\_deployment\_user\_password) | n/a | `string` | `"KieranTest1"` | no |
| <a name="input_email"></a> [email](#input\_email) | n/a | `string` | `"kieranjames16@yahoo.co.uk"` | no |
| <a name="input_eyaml_pri_key"></a> [eyaml\_pri\_key](#input\_eyaml\_pri\_key) | n/a | `string` | `"privatekey"` | no |
| <a name="input_eyaml_pub_key"></a> [eyaml\_pub\_key](#input\_eyaml\_pub\_key) | n/a | `string` | `"publickey"` | no |
| <a name="input_git_pri_key"></a> [git\_pri\_key](#input\_git\_pri\_key) | n/a | `string` | `"privatekey"` | no |
| <a name="input_git_pub_key"></a> [git\_pub\_key](#input\_git\_pub\_key) | n/a | `string` | `"publickey"` | no |
| <a name="input_git_url"></a> [git\_url](#input\_git\_url) | n/a | `string` | `"git@github.com:KieranJamess/KJ-Repo.git"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"puppet"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"KJTest"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"KJTest"` | no |
| <a name="input_vmsize"></a> [vmsize](#input\_vmsize) | n/a | `string` | `"Standard_DS3_v2"` | no |

## Outputs

No outputs.
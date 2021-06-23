/*
    terraform{
        required_version = "2.13.0"
        backend "azurerm"{
            feature {}
        }
    }
/*data "terraform_remote_state" "vpc"{
    backend = "remote"
    organisation = Practice_ars
    workspace = {
        name = b2g_infra_test 
    }
    config ={
        organisation = Practice_ars
        workspace = {
            name = b2g_infra_test 
        }
    }
}
*/
*/

provider "azurerm" {
    version ="~>2.46.0"
    features {}
}
#creating resouse group
#az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
#Create a service principal with the ( az ad sp create-for-rbac )command
resource "azurerm_resource_group" "myterraformgroup"{
    name="myResourceGroup_ars"
    location="eastus"
    tags ={
        environment="Terraform Demo"
    }
}

resource "azurerm_app_service_plan" "myterraformgroup" {
    name                = "slotAppServicePlan"
    location            = azurerm_resource_group.myterraformgroup.location
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "myterraformgroup" {
    name                = "slotAppServicears"
    location            = azurerm_resource_group.myterraformgroup.location
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    app_service_plan_id = azurerm_app_service_plan.myterraformgroup.id
}

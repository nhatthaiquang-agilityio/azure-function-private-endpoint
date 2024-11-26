data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Azure Storage
resource "azurerm_storage_account" "example" {
  name                     = "${var.az_function_storage_account_name}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "application_insights" {
  name                = "application-insights"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = "web"
}

# Azure Service Plan
resource "azurerm_service_plan" "example" {
  name                = "rk-app-service-plan01"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Windows"
  # Windows Premium Plan
  sku_name            = "P1v2"
}

# Azure Function
resource "azurerm_windows_function_app" "example_az_func" {
  name                = "${var.azurerm_windows_function_app_name}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  storage_account_name = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id      = azurerm_service_plan.example.id

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }

  site_config {
  }
}

# Create NET Interface
resource "azurerm_network_interface" "example" {
  name                = "pe-nic-exampleazfunc"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.pv_endpoint_virtual_network_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Private Endpoint for Azure Function
resource "azurerm_private_endpoint" "pv_endpoint_example_az_func" {
  name                = var.pv_endpoint_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = var.pv_endpoint_virtual_network_id

  tags     			  			= merge(var.tags, {
    environment = var.environment
  })

  private_service_connection {
    name                           = var.az_function_pv_svc_connection
    private_connection_resource_id = azurerm_windows_function_app.example_az_func.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

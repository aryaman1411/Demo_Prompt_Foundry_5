Here is a basic example of how you might use Terraform to deploy a Docker container on Azure. This example assumes that you have already created a Docker image and pushed it to a Docker registry.

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_container_group" "example" {
  name                = "example-containegroup"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "public"
  dns_name_label      = "acctestcontainergroup"
  os_type             = "Linux"

  container {
    name   = "example-container"
    image  = "generated_app_image"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
```

This Terraform code does the following:

- Defines a provider for Azure Resource Manager (azurerm).
- Creates a resource group in the West Europe region.
- Creates a container group within the resource group.
- Defines a container within the container group, specifying the Docker image to use (in this case, "generated_app_image"), the amount of CPU and memory to allocate to the container, and the ports to expose.
- Assigns a public IP address to the container group and sets a DNS name label.
- Sets the operating system type of the container group to Linux.
- Adds a tag to the container group to indicate that it's for testing purposes.

Please replace "generated_app_image" with the actual Docker image name you have. If your Docker image is stored in a private registry, you'll also need to provide a `image_registry_credential` block with the server, username, and password for the registry.
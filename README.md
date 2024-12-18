# Azure Function With Private Endpoint
    + Deploy the code to Azure Function with Private Endpoint via Azure DevOps.(The Az Agent can deploy the Azure Function because they are the same virtual network)
        - Setup Azure Agent to deploy the private Azure Function
        - Create Infrastructure Azure Function with Private Endpoint via Terraform

## Create a Service Connection in Azure DevOps
![Azure Service Connection](./Images/azure-service-connection.png)
![Permission Access To Storage](./Images/permission-access-storage.png)
+ The service connection needs the client Id and client secret. We should be created secret credential(above)

## Manually Create  All Resources:
    + Create a Virtual Machine
    + Create an Azure Function with Private Endpoint
    + Create an Azure DevOps Project
    + Create a Service Connection (Azure DevOps connects to the Azure Cloud)
    + Create an Agent Pool and Install into VM (private network)
    + Deploy the Azure Function (deployment.yml)

## Create Infrastructure via Terraform
### Steps
    + Create manual Storage Account & Container. It saves the terraform state file.
    + Create an Azure Function with Private Endpoint via Terraform (azure-deployment.yml)
        + Create a Virtual Network & Subnet
        + Create an Azure Function
        + Create a Network Interface
        + Create a Private Endpoint and attach it to the Azure Function

    + Create a Virtual Machine with the same virtual network and deploy code to the Azure Function as above(##Create Manual All Resources)

### Set Resource Provider for Terraform
![Resource Provider Permission](./Images/resource-provider-permission.png)

### Delegation Subnet
![Delegation Subnet](./Images/delegation-subnet-error.png)

### Infrastructure Deployment
![Infrastructure Deployment](./Images/infrastructure-deployment.png)
![All Resources](./Images/all-resources.png)

## Notes:
    + For public HTTP Trigger: we will be mapped the Azure Function and an API Management for public the endpoint

## Result
![Disabled Public Azure Function](./Images/disabled-public.png)
![Private Azure Function](./Images/enabled-in-virtual-network.png)
![Agent Pool](./Images/agent-pool.png)
![Setting Azure Agent in VM](./Images/setting-azagent.png)
![Agent is available](./Images/agent-available.png)
![Pipeline](./Images/pipeline.png)
![HTTP Trigger Azure Function](./Images/http-trigger.png)

### References
+ [Inbound Private Endpoint in Azure Function](https://www.michaelscollier.com/inbound-private-endpoints-with-azure-functions/)
# Azure Function with Private Endpoint
    + Deploy the code to Azure Function with Private Endpoint via Azure DevOps
    + The Az Agent can deploy the Azure Function because they are the same virtual network.

### Create a Service Connection in Azure DevOps
![Azure Service Connection](./Images/azure-service-connection.png)
![Permission Access To Storage](./Images/permission-access-storage.png)
+ The service connection needs the client Id and client secret. We should be created secret credential(above)

### Create Manual Resources:
    + Create A Virtual Machine
    + Create an Azure Function with Private Endpoint
    + Create Azure DevOps
    + Create a Service Connection (Azure DevOps connects to the Azure Cloud)
    + Create an Agent Pool and Install into VM (private)
    + Deploy the Azure Function with deployment.yml file.

### Create Infrastructure with Terraform
    + Create manual Storage Account & Container
    + Create an Azure Function with Private Endpoint via Terraform (azure-deployment.yml)

### Set Resource Provider for Terraform
![Resource Provider Permission](./Images/resource-provider-permission.png)

### Notes:
    + For public HTTP Trigger: we will be mapped the Azure Function and an API Management for public the endpoint

### Result
+ ![Disabled Public Azure Function](./Images/disabled-public.png)
+ ![Private Azure Function](./Images/enabled-in-virtual-network.png)
+ ![Agent Pool](./Images/agent-pool.png)
+ ![Setting Azure Agent in VM](./Images/setting-azagent.png)
+ ![Agent is available](./Images/agent-available.png)
+ ![Pipeline](./Images/pipeline.png)
+ ![HTTP Trigger Azure Function](./Images/http-trigger.png)

### References
+ [Inbound Private Endpoint in Azure Function](https://www.michaelscollier.com/inbound-private-endpoints-with-azure-functions/)
# Cloud DevOps using Microsoft Azure Nano Degree Project One

## Introduction

The purpose of this project was to deploy web servers behind a load balancer in Azure using Terraform and Packer. There was also the need to use an Azure Policy to ensure that resources are deployed with tags.

## Dependencies

To be able to deploy this project you will need to have Terraform, Packer and Azure CLI installed. Depending on your set up you may need to use either a Service Principal or your Az CLI account to authenticate with Azure and deploy Terraform and Packer. In my example I use a service principal with the following environment variables for the scripts.

- ARM_CLIENT_ID
- ARM_CLIENT_SECRET
- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID

Information on creating a service principle can be found [here](https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal).

## Instructions

### Policy Deployment

To deploy the policies you can either run the set-polices.sh script in the policies folder or run the commands within the script individually. The script or commands need to be run within the same directory as the policies themselves.

### Packer Deployment

To deploy packer you need a resource group in Azure, In the packer template (server.json) I have specified the resource group packer-rg however this can be changed to suit your needs, if you change this ensure you change the terraform to match.

You can create a resource group using Azure CLI by running:

```bash
az group create --name <resourcegroup> --location <myLocation>
```

Once you have got the resource group you can deploy packer by running the below from the packer folder:

```bash
packer build server.json
```

### Terraform Deployment

To deploy the Terraform open the Terraform folder in your console and run the below commands:

```bash
terraform init
terraform plan -out tf.tfplan
terraform apply tf.tfplan
```

NOTE: In the Terraform folder there is a variables file which can be updated to allow you to change the amount of VMs deployed, project name etc. To update this simply change the default value in each variable block.

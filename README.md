# Terraform and Glue Job Execution Guide

## Prerequisites

Ensure you have the following installed before proceeding or use the dev container:
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configured with appropriate credentials
- Apache Spark installed for local execution of Glue jobs

## Terraform Deployment

### Initialize Terraform
Run the following command to initialize Terraform in your project:
```sh
terraform init
```
This command initializes the Terraform working directory by downloading necessary provider plugins and setting up the backend.

### Plan Terraform Changes
To preview the changes Terraform will make to your infrastructure, execute:
```sh
terraform plan
```
This command compares the current infrastructure state with the desired configuration and shows the planned changes.

### Apply Terraform Changes
Deploy the infrastructure using:
```sh
terraform apply
```
Terraform will prompt for confirmation before applying changes. To bypass the prompt, use:
```sh
terraform apply -auto-approve
```

## Running the Glue Job Locally
To test the AWS Glue job locally, use the following command:
```sh
spark-submit ./scripts/main.py
```
Ensure that Spark is properly installed and configured before running this command.

## Cleanup
To remove all Terraform-managed resources, run:
```sh
terraform destroy
```
This will prompt for confirmation before deleting resources. To skip confirmation, use:
```sh
terraform destroy -auto-approve

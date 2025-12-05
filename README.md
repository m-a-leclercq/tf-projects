# Terraform Elastic Stack Multi-Project Setup

This Terraform configuration automatically creates dedicated Kibana spaces, roles, and users.

## Prerequisites

- Terraform >= 1.0
- Access to an Elasticsearch cluster
- Administrative credentials for Elasticsearch

## What This Creates

For each project (A and B):

1. **Kibana Space**: A dedicated space named "Project X"
2. **Role**: A role with read/write permissions for:
   - `logs-projectx-*`
   - `metrics-projectx-*`
   - `traces-projectx-*`
3. **User**: A native user named `projectx` with a randomly generated password

## Configuration

Configure the provider directly in the `providers.tf` file. Other authentications formats are available (API Key).

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## Outputs

- `project_credentials`: Complete credentials for all projects

## Security Notes

- Passwords are randomly generated with 20 characters including special characters
- Store the Terraform state file securely as it contains sensitive credentials
- Consider using a remote state backend with encryption
- The credentials outputs are displayed in plain text - handle with care

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

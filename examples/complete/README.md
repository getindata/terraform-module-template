# Complete Example

This example demonstrates the full capabilities of the terraform-module-template using the context provider for advanced naming schemes and configurations.

## Features Demonstrated

- Context provider integration with custom properties
- Advanced naming scheme configuration
- Custom context templates for flexible naming patterns
- Sub-resource handling

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan with the fixtures file:
   ```bash
   terraform plan -var-file="fixtures.tfvars"
   ```

3. Apply the configuration:
   ```bash
   terraform apply -var-file="fixtures.tfvars"
   ```

## Configuration Files

- `main.tf` - Module instantiation with hardcoded values
- `providers.tf` - Provider configurations (context and null providers)
- `fixtures.tfvars` - Context templates configuration
- `versions.tf` - Provider version constraints

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context_templates"></a> [context\_templates](#input\_context\_templates) | Map of context templates used for naming conventions | `map(string)` | `{}` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_module_template"></a> [terraform\_module\_template](#module\_terraform\_module\_template) | ../../ | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example_output"></a> [example\_output](#output\_example\_output) | Example output of the module |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_context"></a> [context](#requirement\_context) | ~> 0.4.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |

## Resources

No resources.
<!-- END_TF_DOCS -->

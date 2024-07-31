# Simple Example

```terraform
module "terraform_module_template" {
  source = "../../"

  example_var = "This is a example value."
  sub_resource = {
    example_var = "This is a example value of sub resource."
  }
}
```

## Usage
```
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

<!-- BEGIN_TF_DOCS -->




## Inputs

No inputs.

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
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |

## Resources

No resources.
<!-- END_TF_DOCS -->

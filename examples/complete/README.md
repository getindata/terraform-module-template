# Complete Example

```terraform
module "terraform_module_template" {
  source  = "../../"
  context = module.this.context

  example_var = "This is a example value."
  sub_resource = {
    example_var = "This is a example value of sub resource."
  }
}
```

## Usage
```
terraform init
terraform plan -var-file fixtures.tfvars -out tfplan
terraform apply tfplan
```

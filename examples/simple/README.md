# Simple Example

```terraform
module "terraform_module_template" {
  source  = "../../"

  example_var = "This is a example value."
}
```

## Usage
```
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

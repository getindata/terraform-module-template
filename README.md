# Terraform Module Template


> **Warning**:
> This is a template document. Remember to **remove** all text in _italics_ and **update** Module name, Repo name and links/badges to the actual name of your GitHub repository/module!!!

<!--- Pick Cloud provider Badge -->
<!---![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white) -->
<!---![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white) -->
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
<!---![Snowflake](https://img.shields.io/badge/-SNOWFLAKE-249edc?style=for-the-badge&logo=snowflake&logoColor=white) -->
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-module-template/)
![Release](https://badgen.net/github/release/getindata/terraform-module-template/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

_Brief Description of MODULE:_

* _What it does_
* _What technologies it uses_

> **Warning**:
> _When using "Invicton-Labs/deepmerge/null" module - pin `tflint` version to `v0.41.0` in [pre-commit.yaml](.github/workflows/pre-commit.yml) to avoid failing `tflint` checks_

## USAGE

_Example usage of the module - terraform code snippet_

```terraform
module "template" {
  source = "getindata/template/null"
  # version  = "x.x.x"

  example_var = "foo"
}
```

## NOTES

_Additional information that should be made public, for ex. how to solve known issues, additional descriptions/suggestions_

## EXAMPLES

- [Simple](examples/simple) - Basic usage of the module
- [Complete](examples/complete) - Advanced usage of the module

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context_templates"></a> [context\_templates](#input\_context\_templates) | Map of context templates used for naming conventions - this variable supersedes `naming_scheme.properties` and `naming_scheme.delimiter` configuration | `map(string)` | `{}` | no |
| <a name="input_example_var"></a> [example\_var](#input\_example\_var) | Example variable passed into the module | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource | `string` | n/a | yes |
| <a name="input_name_scheme"></a> [name\_scheme](#input\_name\_scheme) | Naming scheme configuration for the resource. This configuration is used to generate names using context provider:<br>    - `properties` - list of properties to use when creating the name - is superseded by `var.context_templates`<br>    - `delimiter` - delimited used to create the name from `properties` - is superseded by `var.context_templates`<br>    - `context_template_name` - name of the context template used to create the name<br>    - `replace_chars_regex` - regex to use for replacing characters in property-values created by the provider - any characters that match the regex will be removed from the name<br>    - `extra_values` - map of extra label-value pairs, used to create a name<br>    - `uppercase` - convert name to uppercase | <pre>object({<br>    properties            = optional(list(string), ["environment", "name"])<br>    delimiter             = optional(string, "-")<br>    context_template_name = optional(string, "resource-type")<br>    replace_chars_regex   = optional(string, "[^a-zA-Z0-9_-]")<br>    extra_values          = optional(map(string))<br>    uppercase             = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_sub_resource"></a> [sub\_resource](#input\_sub\_resource) | Some other resource that is part of stack/module | <pre>object({<br>    example_var           = string<br>    context_template_name = optional(string)<br>  })</pre> | n/a | yes |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example_output"></a> [example\_output](#output\_example\_output) | Example output of the module |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_context"></a> [context](#provider\_context) | ~> 0.4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_context"></a> [context](#requirement\_context) | ~> 0.4.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |

## Resources

| Name | Type |
|------|------|
| [null_resource.output_input](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.subresource](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [context_label.subresource](https://registry.terraform.io/providers/cloudposse/context/latest/docs/data-sources/label) | data source |
| [context_label.this](https://registry.terraform.io/providers/cloudposse/context/latest/docs/data-sources/label) | data source |
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/REPO_NAME/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-module-template" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

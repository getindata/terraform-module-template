# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Terraform module template repository designed to standardize the structure for creating new Terraform modules. The template uses CloudPosse's `context` provider for consistent naming and tagging conventions.

## Key Architecture Patterns

### Context and Labeling System

Use of `context.tf` (terraform CloudPosse `null-label` module) is now deprecated in all our modules, instead CloudPosse's `context` provider should be used. We also created a default set of variables to unify resource naming:

1. Standard variables (this is an example for `snowflake-warehouse`):

  ```hcl
  variable "name" {
    description = "Name of the resource"
    type        = string
  }

  variable "name_scheme" {
    description = <<EOT
    Naming scheme configuration for the resource. This configuration is used to generate names using context provider:
      - `properties` - list of properties to use when creating the name - is superseded by `var.context_templates`
      - `delimiter` - delimited used to create the name from `properties` - is superseded by `var.context_templates`
      - `context_template_name` - name of the context template used to create the name
      - `replace_chars_regex` - regex to use for replacing characters in property-values created by the provider - any characters that match the regex will be removed from the name
      - `extra_values` - map of extra label-value pairs, used to create a name
      - `uppercase` - convert name to uppercase
    EOT
    type = object({
      properties            = optional(list(string), ["environment", "name"])
      delimiter             = optional(string, "_")
      context_template_name = optional(string, "snowflake-warehouse")
      replace_chars_regex   = optional(string, "[^a-zA-Z0-9_]")
      extra_values          = optional(map(string))
      uppercase             = optional(bool, true)
    })
    default = {}
  }

  variable "context_templates" {
    description = "Map of context templates used for naming conventions - this variable supersedes `naming_scheme.properties` and `naming_scheme.delimiter` configuration"
    type        = map(string)
    default     = {}
  }
  ```

2. Resource name creation (label taken from datasource and used in resource):

  ```hcl
  locals {
    context_template = lookup(var.context_templates, var.name_scheme.context_template_name, null)
  }

  data "context_label" "this" {
    delimiter  = local.context_template == null ? var.name_scheme.delimiter : null
    properties = local.context_template == null ? var.name_scheme.properties : null
    template   = local.context_template

    replace_chars_regex = var.name_scheme.replace_chars_regex

    values = merge(
      var.name_scheme.extra_values,
      { name = var.name }
    )
  }

  resource "snowflake_warehouse" "this" {
    name    = var.name_scheme.uppercase ? upper(data.context_label.this.rendered) : data.context_label.this.rendered
    comment = var.comment
  }
  ```

3. Sample provider configuration:

  ```hcl
  provider "context" {
    properties = {
      "environment" = {}
      "name"        = {}
    }
    values = {
      environment = "dev"
    }
  }
  ```

4. Sample tfvars with context templates:

  ```hcl
  context_templates = {
    snowflake-role              = "{{.environment}}_{{.name}}"
    snowflake-project-warehouse = "{{.environment}}_{{.project}}_{{.name}}"
    snowflake-warehouse         = "{{.environment}}_{{.name}}"
    snowflake-warehouse-role    = "{{.prefix}}_{{.environment}}_{{.warehouse}}_{{.name}}"
  }
  ```

### Module Structure

Standard Terraform module files:

- `main.tf` - Primary resource definitions with null_resource examples
- `variables.tf` - Input variables including example_var and sub_resource object
- `outputs.tf` - Output value definitions  
- `locals.tf` - Local value computations
- `versions.tf` - Provider version constraints
- `providers.tf` - Local terraform provider configuration
- `bakend.tf` - Local terraform backend configuration
- `examples/` - Directory with example usage of module, usually `simple` (module with minimal configuration) and `complete` (full module variable usage with any suggestions and configurations that might be a good example for future use) is created.
- `modules/` - Standard directory that stores any submodules used within this module (if needed)

## Common Development Commands

### Terraform Operations

```bash
# Initialize and validate
terraform init
terraform validate

# Format and plan
terraform fmt -recursive
terraform plan

# Apply changes
terraform apply
```

### Pre-commit Hooks

```bash
# Install hooks
pre-commit install

# Run all hooks
pre-commit run --all-files

# Run specific validations
pre-commit run terraform-validate
pre-commit run terraform-fmt  
pre-commit run tflint
```

### Linting and Documentation

```bash
# Run TFLint with custom config
tflint --config=.tflint.hcl

# Security scanning
checkov -d . --skip-check CKV_TF_1
```

## Pre-commit Configuration

Comprehensive pre-commit hooks configured in `.pre-commit-config.yaml`:

- `terraform-validate` - Validates configuration (runs terraform init)
- `terraform-fmt` - Formats code
- `tflint` - Linting with custom `.tflint.hcl` config  
- `terraform-docs` - Auto-generates documentation
- `checkov` - Security scanning (skips CKV_TF_1 for module sources)
- Standard Git hooks (merge conflict detection, YAML validation, EOF fixing)

## Template Usage Notes

When using this template:

1. Replace placeholder text in italics from README.md
2. Update repository name, badges, and links to match your module
3. Replace example variables (`example_var`, `sub_resource`) with actual module variables

## Subresource Context Handling

For modules that need multiple resources with different naming patterns, use the subresource context template pattern:

### Subresource Pattern Implementation

1. **Add context_template_name to subresource variables**:

  ```hcl
  variable "sub_resource" {
    description = "Some other resource that is part of stack/module"
    type = object({
      example_var           = string
      context_template_name = optional(string)  # Allows subresource to use different template
    })
  }
  ```

2. **Create subresource template lookup in locals**:

  ```hcl
  locals {
    context_template = lookup(var.context_templates, var.name_scheme.context_template_name, null)
    subresource_context_template = lookup(var.context_templates, 
      coalesce(var.sub_resource.context_template_name, var.name_scheme.context_template_name), 
      null
    )
  }
  ```

3. **Use separate data sources for each resource type**:

  ```hcl
  data "context_label" "this" {
    template = local.context_template
    values = merge(
      var.name_scheme.extra_values,
      { name = var.name }
    )
  }

  data "context_label" "subresource" {
    template = local.subresource_context_template
    values = merge(
      var.name_scheme.extra_values,
      { name = var.name }
    )
  }
  ```

4. **Example context templates for different resource types**:

  ```hcl
  context_templates = {
    resource-type    = "{{.environment}}-{{.project}}-{{.name}}"
    subresource-type = "{{.environment}}-{{.project}}-{{.name}}-{{.sub}}"
  }
  ```

5. **Provider configuration with additional properties**:

  ```hcl
  provider "context" {
    properties = {
      "environment" = {}
      "name"        = {}
      "project"     = {}
      "sub"         = {}
    }
    values = {
      environment = "dev"
      project     = "myproject"
      sub         = "sub"
    }
  }
  ```

### Key Principles for Subresource Handling

- **Single source of truth**: Use one `extra_values` from `name_scheme` - don't duplicate configuration
- **Template-driven**: Let context provider and templates handle value logic, avoid hardcoding
- **Optional override**: Subresources can specify their own `context_template_name` or inherit from main resource
- **Clean separation**: Each resource type gets its own data source with appropriate template
- **Provider-managed values**: Set values like `sub = "sub"` in the context provider, not in module logic

## Development hints

- Always use terraform mcp server to download most up to date documentation and versions
- Try to use Context7 mcp server to get information about additional libraries
- Always use `getindata` modules, if available, instead of unknown modules or raw resources
- Always use terraform best practices when creating code, planning and reviewing
- Always try to create code that is as short as possible
- Always create code that is readable and easily understandable
- **Context Provider Best Practices**:
  - Move provider configurations to `providers.tf` files, not in `main.tf`
  - Use `.tfvars` files for context templates configuration in examples
  - Keep naming logic in context provider and templates, avoid hardcoded values in resources
  - Use single `extra_values` source to avoid configuration duplication

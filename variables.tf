variable "example_var" {
  description = "Example variable passed into the module"
  type        = string
}

variable "sub_resource" {
  description = "Some other resource that is part of stack/module"
  type = object({
    example_var           = string
    context_template_name = optional(string)
  })
}

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
    delimiter             = optional(string, "-")
    context_template_name = optional(string, "resource-type")
    replace_chars_regex   = optional(string, "[^a-zA-Z0-9_-]")
    extra_values          = optional(map(string))
    uppercase             = optional(bool, false)
  })
  default = {}
}

variable "context_templates" {
  description = "Map of context templates used for naming conventions - this variable supersedes `naming_scheme.properties` and `naming_scheme.delimiter` configuration"
  type        = map(string)
  default     = {}
}

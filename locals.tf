locals {
  context_template = lookup(var.context_templates, var.name_scheme.context_template_name, null)
  subresource_context_template = lookup(var.context_templates, 
    coalesce(var.sub_resource.context_template_name, var.name_scheme.context_template_name), 
    null
  )
}

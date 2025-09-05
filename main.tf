# Example resource that outputs the input value and 
# echoes it's base64 encoded version locally 

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

data "context_label" "subresource" {
  delimiter  = local.subresource_context_template == null ? var.name_scheme.delimiter : null
  properties = local.subresource_context_template == null ? var.name_scheme.properties : null
  template   = local.subresource_context_template

  replace_chars_regex = var.name_scheme.replace_chars_regex

  values = merge(
    var.name_scheme.extra_values,
    { name = var.name }
  )
}

resource "null_resource" "output_input" {
  triggers = {
    name  = var.name_scheme.uppercase ? upper(data.context_label.this.rendered) : data.context_label.this.rendered
    input = var.example_var
  }

  provisioner "local-exec" {
    command = "echo ${var.example_var} | base64"
  }
}

resource "null_resource" "subresource" {
  triggers = {
    name  = var.name_scheme.uppercase ? upper(data.context_label.subresource.rendered) : data.context_label.subresource.rendered
    input = var.sub_resource.example_var
  }

  provisioner "local-exec" {
    command = "echo ${var.sub_resource.example_var} | base64"
  }
}

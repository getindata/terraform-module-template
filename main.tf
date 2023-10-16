# Example resource that outputs the input value and 
# echoes it's base64 encoded version locally 

resource "null_resource" "output_input" {
  count = local.enabled ? 1 : 0

  triggers = {
    name  = local.name_from_descriptor
    input = var.example_var
  }

  provisioner "local-exec" {
    command = "echo ${var.example_var} | base64"
  }
}

module "subresource_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context

  attributes = ["sub"]
}

resource "null_resource" "subresource" {
  count = local.enabled ? 1 : 0

  triggers = {
    name  = local.subresource_name_from_descriptor
    input = var.sub_resource.example_var
  }

  provisioner "local-exec" {
    command = "echo ${var.sub_resource.example_var} | base64"
  }
}

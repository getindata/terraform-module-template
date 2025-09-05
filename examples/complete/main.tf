module "terraform_module_template" {
  source = "../../"

  context_templates = var.context_templates

  name        = "example"
  example_var = "This is a example value."

  sub_resource = {
    example_var           = "This is a example value of sub resource."
    context_template_name = "subresource-type"
  }
}

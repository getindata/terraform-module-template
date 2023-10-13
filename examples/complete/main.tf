module "terraform_module_template" {
  source  = "../../"
  context = module.this.context

  example_var = "This is a example value."
  sub_resource = {
    example_var = "This is a example value of sub resource."
  }
}

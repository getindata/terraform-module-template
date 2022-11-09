module "terraform_module_template" {
  source  = "../../"
  context = module.this.context

  example_var = "This is example value."
}

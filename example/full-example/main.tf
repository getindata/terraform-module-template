module "terraform-module-template" {
  source  = "../../"
  context = module.this.context

  example_var = "This is example value."
}

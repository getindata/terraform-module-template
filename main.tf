# Example resource that outputs the input value and 
# echoes it's base64 encoded version locally 

resource "null_resource" "output_input" {
  triggers = {
    name  = local.name_from_descriptor
    input = var.example_var
  }

  provisioner "local-exec" {
    command = "echo ${var.example_var} | base64"
  }
}

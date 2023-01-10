# Example output from the module

output "example_output" {
  description = "Example output of the module"
  value       = one(null_resource.output_input[*].id)
}

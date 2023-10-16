variable "example_var" {
  description = "Example variable passed into the module"
  type        = string
}

variable "descriptor_name" {
  description = "Name of the descriptor used to form a resource name"
  type        = string
  default     = "resource-type"
}

variable "sub_resource" {
  description = "Some other resource that is part of stack/module"
  type = object({
    descriptor_name = optional(string, "sub-resource-type")
    example_var     = string
  })
}

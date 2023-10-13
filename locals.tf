locals {
  # Get a name from the descriptor. If not available, use default naming convention.
  # Trim and replace function are used to avoid bare delimiters on both ends of the name and situation of adjacent delimiters.
  #
  # todo: Build a wrapper module around context module with name from descriptor feature
  name_from_descriptor = module.this.enabled ? trim(replace(
    lookup(module.this.descriptors, var.descriptor_name, module.this.id), "/${module.this.delimiter}${module.this.delimiter}+/", module.this.delimiter
  ), module.this.delimiter) : null

  subresource_name_from_descriptor = module.subresource_label.enabled ? trim(replace(
    lookup(module.subresource_label.descriptors, var.sub_resource.descriptor_name, module.subresource_label.id), "/${module.subresource_label.delimiter}${module.subresource_label.delimiter}+/", module.subresource_label.delimiter
  ), module.subresource_label.delimiter) : null

  enabled = module.this.enabled
}

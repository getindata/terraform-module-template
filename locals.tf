locals {
  # Get a name from the descriptor. If not available, use default naming convention.
  # Trim and replace function are used to avoid bare delimiters on both ends of the name and situation of adjacent delimiters.
  name_from_descriptor = trim(replace(
    lookup(module.this.descriptors, "module-resource-name", module.this.id), "/${module.this.delimiter}${module.this.delimiter}+/", ""
  ), module.this.delimiter)
}

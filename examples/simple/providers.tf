provider "null" {
  # Configuration options
}

provider "context" {
  properties = {
    "environment" = {}
    "name"        = {}
  }
  values = {
    environment = "dev"
  }
}

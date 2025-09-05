provider "null" {
  # Configuration options
}

provider "context" {
  properties = {
    "environment" = {}
    "name"        = {}
    "project"     = {}
    "sub"         = {}
  }
  values = {
    environment = "dev"
    project     = "myproject"
    sub         = "sub"
  }
}

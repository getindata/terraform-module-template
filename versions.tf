# Example configuration of terraform providers

terraform {
  required_version = ">= 0.15.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

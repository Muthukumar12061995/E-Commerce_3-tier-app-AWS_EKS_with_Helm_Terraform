terraform {
  required_version = ">=1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.49"
    }
  }
}

# aws provider configuration

provider "aws" {
  region  = local.region
  profile = local.tf-profile

  # Optional - assume role to get access to manage aws resources 
  # assume_role {
  #   role_arn = ""
  #   session_name = ""
  # }

  default_tags {
    tags = {
      "Cost"    = "DXB-8080"
      "Project" = "DXB-P-1217"
      "Team"    = "SuperNovas"
    }
  }
}

# Helm provider configuration

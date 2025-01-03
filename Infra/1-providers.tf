terraform {
  required_version = ">=1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.49"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

# provider configuration blocks

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

provider "kubernetes" {
  host = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.auth.token
}

provider "helm" {
  kubernetes {
    host = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.auth.token
  }
}


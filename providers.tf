terraform {
  cloud {
    organization = "Demo-3i"

    workspaces {
      name = "learning-terraform-3087701"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}


provider "aws" {
  region = var.aws_region
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "erickrazr"

    workspaces {
      name = "Tech-Ex-Infra"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


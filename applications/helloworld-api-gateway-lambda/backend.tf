terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
        }
    }

    required_version = ">= 1.1.0"
}

provider "aws" {
  region  = "ap-southeast-1"
}


terraform {
    backend "s3" {
        encrypt              = true
        bucket               = "evolt-failover-tfstate"
        region               = "ap-southeast-1"
        key                  = "helloworld-api-gateway.tfstate"
        profile              = "default"
        workspace_key_prefix = "wk7_terraform"
    }
}

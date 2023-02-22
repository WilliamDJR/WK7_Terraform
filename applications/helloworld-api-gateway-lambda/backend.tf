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
  region  = "ap-southeast-2"
}


terraform {
    backend "s3" {
        encrypt              = true
        bucket               = "tfstate-willido"
        region               = "ap-southeast-2"
        key                  = "helloworld-api-gateway.tfstate"
        profile              = "default"
    }
}

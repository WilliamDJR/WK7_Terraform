terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ef66fb3631e10714"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance2"
  }
}

resource "aws_instance" "api_server" {
  ami           = "ami-0ef66fb3631e10714"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

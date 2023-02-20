terraform {
    backend "s3" {
        encrypt              = true
        bucket               = "terraform-state-file"
        region               = "ap-southeast-1"
        key                  = "helloworld-openapi-gateway.tfstate"
        profile              = "default"
        workspace_key_prefix = "wk7_terraform"
    }
}

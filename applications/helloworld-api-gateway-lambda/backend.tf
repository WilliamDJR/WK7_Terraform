terraform {
    backend "s3" {
        encrypt              = true
        bucket               = "terraform-state-file"
        region               = "ap-southeast-2"
        key                  = "helloworld-api-gateway.tfstate"
        profile              = "default"
        workspace_key_prefix = "wk7_terraform"
    }
}

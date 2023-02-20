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

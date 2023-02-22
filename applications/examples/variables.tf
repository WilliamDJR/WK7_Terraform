variable "ubuntu_instance_images" {
    type = map
    default = {
            ubuntu18 = "ami-0075a67de5ab4fa5e"
            ubuntu20 = "ami-00c76c78e78a3dcd4"
            ubuntu22 = "ami-06933f99c7b8ac912"
    }
}
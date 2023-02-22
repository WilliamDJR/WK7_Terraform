variable "ubuntu_instance_images" {
    type = map
    default = {
            ubuntu18 = "ami-00070c60585f808dc"
            ubuntu20 = "ami-00c76c78e78a3dcd4"
            ubuntu22 = "ami-00eab542a0ac25a2d"
    }
}
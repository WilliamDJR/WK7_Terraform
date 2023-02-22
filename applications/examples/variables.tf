variable "ubuntu_instance_images" {
    type = map
    default = {
            ubuntu18 = "ami-0331cab4f961a4e3e"
            ubuntu20 = "ami-0ec19a300f3097b5a"
            ubuntu22 = "ami-08f0bc76ca5236b20"
    }
}
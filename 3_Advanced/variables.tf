variable "app_name" {
  description = "Values of the Name tag for the EC2 instance"
  type        = list(any)
  default     = ["app1", "app2", "app3"]
}
variable "app_count" {
  description = "Number of EC2 instances to be created"
  type        = number
  default     = 2
}

variable "api_name" {
  description = "Values of the Name tag for the EC2 instance"
  type        = map(any)
  default = {
    "ins1" = "api1"
    "ins2" = "api2"
    "ins3" = "api3"
  }
}

variable "high_availability" {
  description = "If this is a multiple instance deployment, choose `true` to deploy more instances"
  type        = bool
  default     = false
}

variable "ubuntu_instance_images" {
  type = map(any)
  default = {
    ubuntu18 = "ami-0331cab4f961a4e3e"
    ubuntu20 = "ami-0ec19a300f3097b5a"
    ubuntu22 = "ami-08f0bc76ca5236b20"
  }
}
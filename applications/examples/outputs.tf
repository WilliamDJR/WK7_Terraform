output "ubuntu_images" {
  value = data.aws_ami_ids.ubuntu_ids.ids
}

output "ubuntu_names" {
  value = {
    for u in data.aws_ami.ubuntu:
      u.image_id => u.name
  }
}

locals {
  ubuntu22 = lookup(data.aws_ami.ubuntu,"22.04","")
}


output "ubuntu22_names" {
  value = {
    for u in ubuntu22:
      u.image_id => u.name
  }
}
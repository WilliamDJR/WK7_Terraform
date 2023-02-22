output "ubuntu_images" {
  value = data.aws_ami_ids.ubuntu_ids.ids
}

output "ubuntu_names" {
  value = {
    for u in data.aws_ami.ubuntu:
      u.image_id => u.name
  }
}

output "ubuntu22_names" {
  value = lookup(data.aws_ami.ubuntu[*],"name","")
}
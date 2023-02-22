output "ubuntu_images" {
  value = data.aws_ami_ids.ubuntu_ids.ids
}

output "ubuntu_names" {
  value = {
    for u in data.aws_ami.ubuntu:
      u.image_id => u.name
  }
}

output "public_ips" {
  value = data.aws_instances.running_instances.public_ips
}
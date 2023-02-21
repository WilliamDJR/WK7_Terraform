output "ubuntu_images" {
  value = data.aws_ami_ids.ubuntu_ids.ids
}

output "ubuntu_names" {
  value = data.aws_ami.ubuntu[*].name
}
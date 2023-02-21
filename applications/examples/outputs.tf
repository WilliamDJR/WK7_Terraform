output "ubuntu_images" {
  value = data.aws_ami_ids.ubuntu.ids
}
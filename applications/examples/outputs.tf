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
  instance_data = [
    for i in range(length(data.aws_instances.running_instances.ids)) :
    {
      id = element(data.aws_instances.running_instances.ids, i)
      public_ip = element(data.aws_instances.running_instances.public_ips, i)
    }
  ]
}
output "running_instances" {
  value = local.instance_data
}
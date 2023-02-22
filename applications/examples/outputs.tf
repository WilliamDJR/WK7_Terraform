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
      private_ip = element(data.aws_instances.running_instances.private_ips, i)
    }
  ]
}
output "running_instances" {
  value = local.instance_data
}


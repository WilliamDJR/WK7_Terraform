data "aws_ami_ids" "ubuntu_ids" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*22.04*"]
  }
}

data "aws_ami" "ubuntu" {
    for_each = toset(data.aws_ami_ids.ubuntu_ids.ids)
    owners      = ["099720109477"] # Canonical

    filter {
        name   = "image-id"
        values = [each.value] # replace with the actual AMI ID
    }
}

data "aws_ami" "ubunt22" {
    most_recent = true
    owners = ["099720109477"] # Canonical
    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu*22.04*"]
    }    
}

resource "aws_instance" "example" {
    for_each = ["ubuntu20","ubuntu18", "ubuntu22"]
    ami = lookup(var.instance_images, each.value, "buntu22")
    
    instance_type = "t2.micro"
  
    tags = {
      Name  = each.value
      AMI   = ami
    }
  # other resource configuration
}

data "aws_instances" "running_instances" {
    instance_state_names = ["running"]
}







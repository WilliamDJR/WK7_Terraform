data "aws_ami_ids" "ubuntu_ids" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*"]
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
  count = 3
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t2.micro"
  # other resource configuration
}







resource "aws_key_pair" "ssh_key_1v1" {
  key_name   = "ssh_key_1v1"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "app_server" {
  count         = (var.high_availability == true ? 2 : 1)
  ami           = lookup(var.ubuntu_instance_images, "ubuntu20")
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key_1v1.key_name
  user_data     = templatefile("user_data.tftpl", { name = var.app_name[count.index] })

  tags = {
    Name = var.app_name[count.index]
  }
}

resource "aws_instance" "api_server" {
  for_each      = var.api_name
  ami           = lookup(var.ubuntu_instance_images, "ubuntu22")
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key_1v1.key_name
  user_data     = templatefile("user_data.tftpl", { name = each.value })

  tags = {
    Name = each.value
  }
}




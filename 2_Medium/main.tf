resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

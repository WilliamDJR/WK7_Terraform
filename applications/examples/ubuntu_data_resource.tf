data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

# resource "aws_instance" "example" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   # other resource configuration
# }







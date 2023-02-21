data "aws_ami_ids" "ubuntu_ids" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}
data "aws_ami" "ubuntu" {
    owners      = ["099720109477"] # Canonical

    filter {
        name   = "image-id"
        values = data.aws_ami_ids.ubuntu_ids.ids # replace with the actual AMI ID
    }
}
# resource "aws_instance" "example" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   # other resource configuration
# }







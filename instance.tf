data "aws_ami" "ubuntu" {

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/${var.ami_ubuntu}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "redhat" {

  filter {
    name = "name"
    values = ["${var.ami_redhat}"]
  }

  owners = ["309956199498"]
}
provider "aws" {
  region = "us-west-2"
  profile = "terraform"
}

resource "aws_instance" "example" {
  ami = "ami-a9d09ed1"
  instance_type = "t2.micro"

  tags {
    Name = "terraform-example"
  }
}

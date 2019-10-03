terraform {
  required_version = ">= 0.12.6, <0.13"
}

provider "aws" {
    region = "us-west-2"
    # Allow any 2.x version of the AWS provider
    version = "~> 2.31"
}

resource "aws_instance" "example" {
    ami           = "ami-06f2f779464715dc5"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}
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
    key_name                    = "${var.ec2_key_pair_name}"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {

    name = var.security_group_name

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

variable "security_group_name" {
  type        = string
  default     = "teraform-example-instance"
  description = "The Name of the security group"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The Public IP of the example instance"
}

variable "ec2_key_pair_name" {
  default     = "ec2-keypair"
  description = "Key pair for connecting to launched EC2 instances"
}
provider "aws" {
  version = "~> 2.7"
  region  = "us-east-2"
}

resource "aws_instance" "web" {
  count = 2
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  tags = {
    Name = "devops-2104"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.web.*.private_ip}"
}


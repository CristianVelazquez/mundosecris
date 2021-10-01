Esta actividad esta hecha para primero instanciar las EC2 con
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
terraform init
terraform plan
sin usar el archivo output y luego modificarlas con el main que tengo actualemnte, para usar los archivos de variables como se puede ver en la practica del modulo 6. Yo tengo creado la vpc y la subnet en us-east-2 (ohio). Entonces use esa zona, no la misma que el documento y use otra imagen de ubuntu gratuita.

**********para hacer la modificacion uso*********
provider "aws" {
  version = "~> 2.7"
  region  = "us-east-2"
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}
resource "aws_instance" "web" {
  ami = "ami-00399ec92321828f5"
  subnet_id = data.aws_subnet.selected.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow-ssh-all-test.id]
  key_name = var.key_pair_name
  tags = {
    Name = "Terra-test2"
  }  
}
resource "aws_security_group" "allow-ssh-all-test" {
name = "allow-ssh-all-test"
vpc_id = data.aws_vpc.selected.id
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

terraform plan
terraform apply
verifico que se modifico y luego
terraform destroy   (no lo puedo dejar andando sino me cobran)

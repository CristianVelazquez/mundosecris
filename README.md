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

sin usar el archivo output y luego modificarlas con el main que tengo actualemnte, para usar los archivos de variables como se puede ver en la practica del modulo 6. Yo tengo creado la vpc y la subnet en us-east-2 (ohio). Entonces use esa zona, no la misma que el documento y use otra imagen de ubuntu gratuita.

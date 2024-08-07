resource "aws_vpc" "projvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Project-Vpc"
  }
}

resource "aws_subnet" "projsub" {
  vpc_id     = aws_vpc.projvpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "Project-subnet"
  }
}


resource "aws_internet_gateway" "projigw" {
  vpc_id = aws_vpc.projvpc.id

  tags = {
    Name = "Project-Internet-Gateway"
  }
}

resource "aws_route_table" "proj-route_table" {
  vpc_id = aws_vpc.projvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.projigw.id
  }

  tags = {
    Name = "proj-route-table"
  }
}

resource "aws_route_table_association" "proj-route_table_association" {
  subnet_id      = aws_subnet.projsub.id
  route_table_id = aws_route_table.proj-route_table.id
}


resource "aws_security_group" "jenkinssg" {
  name        = "jenkinssg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.projvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

     ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "Jenkins-security-Group"
  }
}

resource "aws_security_group" "nexussg" {
  name        = "nexussg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.projvpc.id


 ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

     ingress {
    description      = "TLS from VPC"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "Nexus-security-Group"
  }
}
  

resource "aws_security_group" "microk8ssg" {
  name        = "microk8ssg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.projvpc.id


ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "microk8s-security-Group"
  }
}

resource "aws_instance" "jenkins_instance" {
  ami                                             = var.ami_id
  instance_type                                   = var.instance_type
  availability_zone                               = var.availability_zone
  associate_public_ip_address                     = "true"
  vpc_security_group_ids                          = [aws_security_group.jenkinssg.id]
  subnet_id                                       = aws_subnet.projsub.id 
  key_name                                        = "singapore"
  
    tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "nexus_instance" {
  ami                                             = var.ami_id
  instance_type                                   = var.instance_type
  availability_zone                               = var.availability_zone
  associate_public_ip_address                     = "true"
  vpc_security_group_ids                          = [aws_security_group.nexussg.id]
  subnet_id                                       = aws_subnet.projsub.id 
  key_name                                        = "singapore"
  
    tags = {
    Name = "Nexus"
  }
}

resource "aws_instance" "microk8s_instance" {
  ami                                             = var.ami_id
  instance_type                                   = var.instance_type
  availability_zone                               = var.availability_zone
  associate_public_ip_address                     = "true"
  vpc_security_group_ids                          = [aws_security_group.microk8ssg.id]
  subnet_id                                       = aws_subnet.projsub.id 
  key_name                                        = "singapore"
  
    tags = {
    Name = "Micro-k8s"
  }
}

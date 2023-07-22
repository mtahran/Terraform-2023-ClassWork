resource "aws_instance" "wordpress-server" {
    ami           = var.instance_ami
    instance_type = var.instance_type
    key_name      = var.key_name
    user_data     = file("user_data.sh")
    vpc_security_group_ids = [aws_security_group.wordpress-sg.id]
    tags = merge (
      local.common_tags,
      {
        Name  = "wordpress-server-${var.env}" 
      }   
    )
}

resource "aws_security_group" "wordpress-sg" {
  name        = "sg_wp"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = var.aws_vpc

  ingress {
    description      = "open to http from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "http"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "open to ssh from internet"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = var.local_ip
  }
  
  ingress {
    description      = "open to mysql to database"
    from_port        = 3306
    to_port          = 3306
    protocol         = "msql"
    cidr_blocks      = var.private_subnet
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "https"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_wp-${var.env}"
  }
}
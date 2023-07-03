resource "aws_instance" "my-webserver" {
    ami           = data.aws_ami.amazon_linux2.image_id
    instance_type = var.instance_type
    key_name      = var.key_name
    user_data = file("user_data.sh")
    vpc_security_group_ids = [aws_security_group.ssh-port.id]
    tags = merge (
      local.common_tags,
      {
        Name  = "webserver-${var.env}" 
      }   
    )
}

resource "aws_security_group" "ssh-port" {
    name = "webserver-security-group-ssh-${var.env}"
    description = "this sg allowes port 22"
    vpc_id = var.vpc_id

   ingress {
    description = "allows port 22"
    from_port = var.ssh_from_port
    to_port   = var.ssh_to_port
    protocol = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
    from_port = 0
    to_port    = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

  tags = {
    Name = "allow_22"
  }
}
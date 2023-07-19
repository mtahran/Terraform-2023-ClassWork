module "ec2" {
  source                  = "../../child-modules/ec2"
  instance_ami = "ami-06b09bfacae1453cb" #us-east-1, Amazon Linux 2023
  instance_type = "t2.micro"
  key_name = "macbook@400048mbp"
  elastic_ip = ???????
}

output "arn_ebs_volume" {
  value = "aws_ebs_volume.ebs_to_myec2.arn" ???????
}
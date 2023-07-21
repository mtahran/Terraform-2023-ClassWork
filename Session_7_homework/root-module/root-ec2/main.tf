module "ec2" {
  aws_region    = "us-east-1"
  source        = "../../child-modules/ec2"
  instance_ami  = "ami-06b09bfacae1453cb" #us-east-1, Amazon Linux 2023
  instance_type = "t2.micro"
  key_name      = "macbook@400048mbp"
  env           = "dev"
  elastic_ip    = data.terraform_remote_state.newVPC.public_ip
  aws_vpc       = data.terraform_remote_state.newVPC.id
  kms_key_arn   = data.terraform_remote_state.kms-key.arn
}
locals {

  vpc_name       = "finalProject-cloud"
  vpc_cidr_block = "20.10.0.0/16"
  public_subnets = ["20.10.0.0/20", "20.10.16.0/20", "20.10.32.0/20"]
  common_tags = {
    project = "colman"
  }
  ec2_key_name = "finalProject"
  app_ami = "ami-071c3fba3f3ea8b61"
  instance_type = "t2.micro"
}
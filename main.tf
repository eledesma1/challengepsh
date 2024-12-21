module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source    = "./iam"
  role_name = "ec2-rds-role"
  instance_profile = "ec2-instance-profile"
}


module "ec2" {
  source         = "./ec2"
  ami            = "ami-01816d07b1128cd2d"
  instance_type  = "t2.micro"
  instance_name  = "web-server"
  instance_profile  = module.iam.instance_profile_name
  subnet_id      = module.vpc.public_subnetA_id
  security_group_ids = [module.security_groups.ec2_sg_id]
}


module "rds" {
  source               = "./rds"
  private_subnet_ids   = [module.vpc.private_subnetA_ids[0], module.vpc.private_subnetB_ids[0]]
  vpc_security_group_ids = [module.security_groups.rds_sg_id]
}

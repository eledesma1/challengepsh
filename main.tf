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

module "rds_secret" {
  source             = "./secret_manager"
  secret_name        = "rds-credentials"
  secret_description = "RDS PostgreSQL credentials"
  rds_username       = var.rds_username
  rds_password       = var.rds_password
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.9"
  instance_class       = "db.t3.micro"
  db_name              = "challenge_db"

  username             = jsondecode(module.rds_secret.secret_string)["username"]
  password             = jsondecode(module.rds_secret.secret_string)["password"]

  vpc_security_group_ids = [module.security_groups.rds_sg_id]
  skip_final_snapshot  = true

  tags = {
    Name = "challenge-postgres"
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [module.vpc.private_subnetA_ids[0], module.vpc.private_subnetB_ids[0]]

  tags = {
    Name = "rds-subnet-group"
  }
}
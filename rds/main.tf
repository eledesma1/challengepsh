resource "aws_db_subnet_group" "rds" {
  name       = "challenge-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "challenge-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.9"
  instance_class       = "db.t3.micro"
  db_name              = "challenge_db"
  username             = chpsh
  password             = Chall3ng3PSh
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.rds.name
  skip_final_snapshot  = true

  tags = {
    Name = "challenge-postgres"
  }
}

data "aws_secretsmanager_secret_version" "postgres_db_secret" {
  secret_id = aws_secretsmanager_secret.postgres_db_secret.id
}
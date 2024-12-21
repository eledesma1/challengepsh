resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  iam_instance_profile   = var.instance_profile

  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }
}
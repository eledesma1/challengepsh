resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  iam_instance_profile   = var.instance_profile

  vpc_security_group_ids = var.security_group_ids

  key_name        = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = var.instance_name
  }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "my-ec2-key"
  public_key = var.ec2_public_key
}

output "key_name" {
  value = aws_key_pair.ec2_key_pair.key_name
}

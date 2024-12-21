output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnetA_id" {
  value = aws_subnet.publicA.id
}

output "public_subnetB_id" {
  value = aws_subnet.publicB.id
}

output "private_subnetA_ids" {
  value = [aws_subnet.privateA.id]
}

output "private_subnetB_ids" {
  value = [aws_subnet.privateB.id]
}
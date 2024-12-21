resource "aws_iam_role" "ec2_rds_access" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "rds_access_policy" {
  name        = "${var.role_name}-policy"
  description = "Policy to allow EC2 to connect to RDS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBSubnetGroups",
          "rds-db:connect"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_rds_access_attach" {
  role       = aws_iam_role.ec2_rds_access.name
  policy_arn = aws_iam_policy.rds_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.role_name}-profile"
  role = aws_iam_role.ec2_rds_access.name
}

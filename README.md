This Terraform template includes the following modules:

- ec2: Creates a t2.micro EC2 instance named web-server.
- iam: Generates IAM roles for the EC2 instance and RDS database.
- rds: Creates a PostgreSQL database (version 14.9) with a t3.micro instance.
- security_groups:
    - Creates a security group for EC2, with a policy that opens port 22 to my IP address and allows communication with the database.
    - Creates another security group for the RDS instance.
- secret_manager: creates the secret for the RDS keys
- vpc:
    - Creates a VPC with four subnets: two private and two public.
    - Generates the corresponding route table and creates a NAT gateway to enable communication between the RDS instance and the EC2 instance.

Additionally, the template contains the following files:
- main.tf: Specifies the necessary resources for the infrastructure creation.
- providers.tf: Defines the AWS credentials for the account used and the AWS provider plugin.
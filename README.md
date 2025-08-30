**Terraform AWS VPC + EC2 Infrastructure**

# Overview
This project provisions AWS infrastructure using Terraform.
It creates a Virtual Private Cloud (VPC) with both public and private subnets, an Internet Gateway for outbound connectivity, and an EC2 instance in the public subnet accessible via HTTP (port 80).
This setup demonstrates Infrastructure as Code (IaC) principles and modular Terraform design.

# Features
1. VPC with CIDR block 10.0.0.0/16
2. 3 Public Subnets across multiple Availability Zones
3. 3 Private Subnets across multiple Availability Zones
4. Internet Gateway & Public Route Table for internet access
5. Private Route Table with no direct internet access
6. EC2 Instance in public subnet with:
   - Auto-assigned public IP
   - Security Group allowing HTTP (port 80) from anywhere
7. Modular structure: VPC, Subnets, and EC2 separated into Terraform modules

# Usage
1. *Initialize Terraform*
```sh
terraform init
```

2. *Validate the configuration*
```sh
terraform validate
```

3. *Apply the configuration*
```sh
terraform apply -auto-approve
```

4. *Destroy the infrastructure*
```sh
terraform destroy -auto-approve
```

# INPUTS

| Name             | Description                    | Type         | Default                                             | Required               |
| ---------------- | ------------------------------ | ------------ | --------------------------------------------------- | ---------------------- |
| region           | AWS region to deploy resources | string       | `"us-east-1"`                                       | no                     |
| vpc\_cidr        | CIDR block for the VPC         | string       | `"10.0.0.0/16"`                                     | no                     |
| public\_subnets  | List of public subnet CIDRs    | list(string) | `["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]`       | no                     |
| private\_subnets | List of private subnet CIDRs   | list(string) | `["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]` | no                     |
| azs              | Availability Zones to use      | list(string) | `["us-east-1a","us-east-1b","us-east-1c"]`          | no                     |
| instance\_type   | EC2 instance type              | string       | `"t2.micro"`                                        | no                     |
| ami\_id          | AMI ID for EC2 instance        | string       | `""`                                                | yes (must be provided) |

# OUTPUTS

| Name                     | Description                       |
| ------------------------ | --------------------------------- |
| vpc\_id                  | The ID of the created VPC         |
| igw\_id                  | The ID of the Internet Gateway    |
| public\_route\_table\_id | The ID of the Public Route Table  |
| public\_subnet\_ids      | List of IDs of public subnets     |
| private\_subnet\_ids     | List of IDs of private subnets    |
| ec2\_instance\_id        | The ID of the EC2 instance        |
| ec2\_public\_ip          | The Public IP of the EC2 instance |

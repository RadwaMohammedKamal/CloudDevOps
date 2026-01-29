# CloudDevOps
Terraform AWS Cloud Native Platform

- Multi-AZ VPC
- Public / Private / Data subnets
- EKS (Managed Control Plane)
- Prod & Nonprod environments
- S3 remote backend

terraform-aws-platform/
│
├── backend.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── main.tf
│
├── environments/
│   ├── prod.tfvars
│   └── nonprod.tfvars
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── eks/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md



# gcp-infra-via-terraform
gcp-infra-via-terraform/
│
├── modules/                   # Reusable modules
│   ├── vpc/                   # VPC module
│   ├── subnet/                # Subnet module
│   └── vm/                    # VM module
│
├── main.tf                    # Main configuration entry point
├── outputs.tf                 # Outputs for the infrastructure
├── variables.tf               # Input variables for configuration
└── terraform.tfvars           # Variables values (can be environment-specific)

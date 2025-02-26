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

# Lloyds Infra pipeline Architecture Diagram :
    - See the .jpg file in this project folder

# Future improvements
1. use feature brachm PR approval to main
1. add brach based pipeline execuiotion in jenkins
2. Add jenkins groovy script as shared library for validation may be.
2. add code validation and naming convetion check for one argument for demo
3. add lint, security scans testing etc.
4. create different statefile folder in gcp for each env
5. Add manual appoval for produiton release
6. how you can roll back chnages ?
7. remove the pod yaml from code and put in a file
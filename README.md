# 🚀 Terraform Modules for Microsoft Azure

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Azure](https://img.shields.io/badge/Microsoft-Azure-0078D4?logo=microsoftazure)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-green)

## 📖 Overview

This repository contains reusable **Terraform modules** for provisioning and managing Microsoft Azure infrastructure following Infrastructure as Code (IaC) best practices.

The project is designed to provide modular, scalable, and production-ready Azure infrastructure with automated validation using GitHub Actions CI. Modular Terraform configurations help reduce code duplication and improve maintainability.

---

# 📂 Repository Structure

```text
Terraform-Modules
│
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
│
├── Production/
│   ├── Dev/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── Prod/
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── module/
│   ├── AppGateway/
│   ├── Bastion/
│   ├── NSG/
│   ├── NatGatway/
│   ├── Public_ip/
│   ├── Storage_account/
│   ├── Subnets/
│   ├── Virtual_machine/
│   ├── Virtual_network/
│   ├── VnetPeering/
│   └── resource_group/
│
├── .gitleaks.toml
├── .tflint.hcl
├── .gitignore
└── README.md
```

---

# ✨ Features

- Modular Terraform Architecture
- Azure Resource Group Module
- Azure Virtual Network Module
- Azure Subnet Module
- Azure Public IP Module
- Azure NAT Gateway Module
- Azure Network Security Group (NSG) Module
- Azure Application Gateway Module
- Azure Bastion Host Module
- Azure Storage Account Module
- Azure VNet Peering Module
- Azure Virtual Machine Module
- Environment-Based Workflow (Dev / Prod)
- GitHub Actions CI Pipeline
- Terraform Format Validation & Security Scanning (TFLint, tfsec, GitLeaks)

---

# 🛠 Technologies Used

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure as Code |
| Microsoft Azure | Cloud Platform |
| GitHub Actions | CI Pipeline |
| TFLint | Terraform Linting |
| tfsec | Security Scanning |
| Git / Gitleaks | Version Control & Secret Scanning |

---

# ⚙️ CI Pipeline

The GitHub Actions workflow automatically performs:

- Checkout Repository
- Setup Terraform
- Terraform Format Check
- Terraform Init
- Terraform Validate
- TFLint
- tfsec Security Scan

---

# 🚀 Getting Started

## Clone Repository

```bash
git clone https://github.com/amolkhilari1231-sys/Terraform-Modules.git
```

## Go to Project Directory

```bash
cd Terraform-Modules
```

## Initialize & Deploy Environment (e.g. Dev)

```bash
cd Production/Dev

terraform init


## Validate Configuration
```bash
terraform validate


## Format Code

```bash
terraform fmt -recursive
```

## Plan Infrastructure

```bash
terraform plan
```

---

# 📦 Available Modules

| Module | Description |
|---------|-------------|
| Resource Group | Creates Azure Resource Group |
| Virtual Network | Creates Azure VNet |
| Subnets | Creates Azure Subnets |
| Public IP | Creates Azure Public IP |
| NAT Gateway | Creates Azure NAT Gateway |
| Network Security Group | Configures NSGs and security rules |
| Application Gateway | Deploys Azure App Gateway |
| Azure Bastion | Provisions Azure Bastion Host |
| Storage Account | Configures Azure Storage Account |
| VNet Peering | Sets up Virtual Network Peering |
| Virtual Machine | Creates Azure Virtual Machine |

---

# 📌 Best Practices

- Reusable & Parameterized Modules
- Environment Separation (Dev / Prod)
- Clean & Scalable Folder Structure
- Automated GitHub Actions CI Pipeline
- Static Code & Security Analysis
- Version Controlled Infrastructure

---

# 📈 Future Enhancements

- Azure Key Vault Integration
- Azure Load Balancer
- Azure Firewall
- Azure SQL Database
- Private Endpoints
- Azure Monitor & Log Analytics
- Automated Terraform Plan Artifacts
- Checkov & TruffleHog Integration

---

# 👨‍💻 Author

**Amol Khilari**

Azure DevOps Engineer | Terraform | GitHub Actions | Microsoft Azure | Infrastructure as Code

GitHub: [amolkhilari1231-sys](https://github.com/amolkhilari1231-sys)

---

# ⭐ Support

If you found this project useful, don't forget to ⭐ the repository.

# 🚀 Terraform Modules for Microsoft Azure

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Azure](https://img.shields.io/badge/Microsoft-Azure-0078D4?logo=microsoftazure)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-green)

## 📖 Overview

This repository contains reusable **Terraform modules** for provisioning and managing Microsoft Azure infrastructure following Infrastructure as Code (IaC) best practices.

The project is designed to provide modular, scalable, and production-ready Azure infrastructure with automated validation using GitHub Actions CI. Modular Terraform configurations help reduce code duplication and improve maintainability. :contentReference[oaicite:0]{index=0}

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
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
├── module/
│   ├── resource_group/
│   ├── Virtual_network/
│   ├── Subnets/
│   ├── Public_ip/
│   ├── NatGateway/

│   └── Virtual_machine/

│
├── .tflint.hcl
├── .gitignore
└── README.md
```


# ✨ Features

- Modular Terraform Architecture
- Azure Resource Group Module
- Azure Virtual Network Module
- Azure Subnet Module
- Azure Public IP Module
- Azure NAT Gateway Module
- Azure Virtual Machine Module
- GitHub Actions CI Pipeline
- Terraform Format Validation
- Terraform Validate
- TFLint Integration
- tfsec Security Scanning
- Production Ready Folder Structure

---

# 🛠 Technologies Used

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure as Code |
| Microsoft Azure | Cloud Platform |
| GitHub Actions | CI Pipeline |
| TFLint | Terraform Linting |
| tfsec | Security Scanning |
| Git | Version Control |

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

## Go to Project

```bash
cd Terraform-Modules
```

## Initialize Terraform

```bash
cd Production

terraform init
```

## Validate Configuration

```bash
terraform validate
```

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
| Virtual Machine | Creates Azure Linux Virtual Machine |

---

# 📌 Best Practices

- Reusable Modules
- Parameterized Variables
- Clean Folder Structure
- GitHub Actions CI
- Security Scanning
- Infrastructure as Code
- Version Controlled Infrastructure

---

# 📈 Future Enhancements

- Azure Key Vault
- Azure Load Balancer
- Azure Application Gateway
- Azure Bastion
- Azure Firewall
- Azure Storage Account
- Azure SQL Database
- Private Endpoints
- Azure Monitor
- Terraform Plan Artifact
- Checkov Integration
- TruffleHog Secret Scanning

---

# 👨‍💻 Author

**Amol Khilari**

Azure DevOps Engineer | Terraform | GitHub Actions | Microsoft Azure | Infrastructure as Code

GitHub:
https://github.com/amolkhilari1231-sys

---

# ⭐ Support

If you found this project useful, don't forget to ⭐ the repository.

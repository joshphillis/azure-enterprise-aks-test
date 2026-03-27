# Azure Enterprise AKS Test Environment

This repository contains the Terraform configuration for deploying a secure, enterprise-grade Azure Kubernetes Service (AKS) cluster in the **Test environment**. It is part of a modular, multi-environment infrastructure stack designed for scalability, security, and maintainability.

> **Deployment order:**
> 1. **Terraform State** — storage accounts and containers must exist first
> 2. **Landing Zone** — hub networking, firewall, NAT gateway
> 3. **This repo** — reads networking outputs from landing zone remote state

---

## 📦 Components

- **AKS Cluster**: Private cluster with `userDefinedRouting` for firewall-controlled egress
- **System Node Pool**: 2 nodes, `Standard_DS2_v2`, Kubernetes v1.33
- **Remote State Backend**: Azure Blob Storage for Terraform state isolation
- **Landing Zone Integration**: Subnet and firewall private IP sourced from landing zone remote state

---

## 📁 File Structure

| File               | Purpose                                      |
|--------------------|----------------------------------------------|
| `aks.tf`           | AKS cluster definition                       |
| `network.tf`       | Landing zone remote state reference          |
| `providers.tf`     | Azure provider and SP authentication         |
| `backend_test.tf`  | Remote state backend for Test environment    |
| `variables.tf`     | Input variables                              |
| `outputs.tf`       | Output values (cluster name, kubeconfig)     |

---

## 🚫 Security Hygiene

This repo **does not contain**:
- `terraform.tfvars`
- `.terraform/` provider binaries
- `terraform.tfstate`
- Any secrets, credentials, or environment-specific values

All sensitive data is managed locally and excluded via `.gitignore`.

---

## 🚀 Deployment

### Prerequisites
- Landing zone deployed and state accessible in Azure Blob Storage
- Service principal with Contributor rights
- `terraform.tfvars` created locally (never commit this file)

### Deploy
```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

> Ensure your `terraform.tfvars` is stored securely and never committed.

---

## 📌 Notes

- This is the **Test environment only**
- Dev and Prod configurations are maintained in separate repositories
- Egress traffic routes through the hub Azure Firewall via UDR — `outbound_type = "userDefinedRouting"`
- The Test environment was used to validate and resolve AKS bootstrap failures related to outbound routing conflicts and missing firewall egress FQDNs

---

## 📈 Future Enhancements

- Add role-based access control (RBAC) modules
- Integrate Azure Monitor and Log Analytics alerting
- Expand node pool configuration for workload isolation
- Add GitHub Actions CI/CD pipeline for automated deployments

---

## 🛡️ Author

**Joshua Phillis**
Retired Army Major | Cloud & Platform Engineer
GitHub: [@joshphillis](https://github.com/joshphillis)

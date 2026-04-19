# oci-mini-cli
#Lightweight OCI Free-Tier CLI to deploy and manage Ubuntu VM instances using Terraform + OCI CLI
# 🚀 OCI Mini CLI — Free Tier Cloud Automation Tool

![Terraform](https://img.shields.io/badge/Terraform-IaC-blue)
![OCI](https://img.shields.io/badge/Cloud-OCI-red)
![Bash](https://img.shields.io/badge/Shell-Bash-green)

---

## 📌 Overview

OCI Mini CLI is a lightweight command-line tool that automates the deployment and management of Ubuntu virtual machines on Oracle Cloud Infrastructure (OCI).

It is designed specifically for **OCI Free Tier**, handling common issues like:

* Image + shape compatibility
* SSH setup
* Public IP retrieval
* Terraform complexity

---

## ✨ Features

* 🚀 One-command VM deployment
* 🆓 Fully optimized for OCI Free Tier (E2.1.Micro)
* 🧠 Auto-selects compatible Ubuntu image
* 🔐 Automatic SSH key generation
* 🌐 Public IP auto-detection
* 📋 Instance listing
* 🔗 Instant SSH access
* ❌ Safe instance termination
* 🧩 Modular CLI architecture

---

## 🏗️ Architecture

```text
User CLI (tf-project)
        ↓
Bash Modules (lib/)
        ↓
Terraform (Infrastructure as Code)
        ↓
OCI API (Compute + Networking)
```

---

## ⚙️ Tech Stack

* Bash (CLI framework)
* Terraform (Infrastructure as Code)
* Oracle Cloud CLI (OCI)
* OCI Compute + Networking

---

## 📂 Project Structure

```text
oci-mini-cli/
│
├── tf-project           # Main CLI entrypoint
├── install.sh          # Installer script
│
├── lib/
│   ├── config.sh       # Config + environment
│   ├── oci.sh          # OCI logic
│   ├── terraform.sh    # Terraform automation
│   ├── ssh.sh          # SSH + instance management
│
└── tf/                 # Terraform runtime (ignored in git)
```

---

## 🚀 Installation

```bash
git clone https://github.com/YOUR_USERNAME/oci-mini-cli.git
cd oci-mini-cli
bash install.sh
```

---

## 🧑‍💻 Usage

```bash
# Create VM
./tf-project create myapp

# List instances
./tf-project list

# SSH into instance
./tf-project ssh myapp

# Destroy instance
./tf-project destroy myapp
```

---

## 📸 Example Output

```bash
🚀 Deploying myapp...
✅ INSTANCE CREATED

🌐 Public IP: 129.xxx.xxx.xxx

🔗 SSH:
ssh ubuntu@129.xxx.xxx.xxx -i ~/.ssh/id_rsa
```

---

## 🧠 Key Learnings

* Cloud infrastructure automation (OCI)
* Terraform provisioning lifecycle
* Handling real-world cloud constraints
* CLI tool design and modularization
* Debugging image/shape compatibility issues
* Secure SSH key management

---

## ⚠️ Challenges Solved

* ❌ OCI image + shape incompatibility
* ❌ Free-tier compute limits
* ❌ Missing SSH access after provisioning
* ❌ Terraform provider/state issues
* ❌ OCI CLI query handling

---

## 🔮 Future Improvements

* Multi-instance support
* Inventory management system
* Domain + DNS automation
* Cost/quota guard
* Docker packaging
* GitHub Actions CI/CD

---

## 👨‍💻 Author

Syd Moshin
Cloud / DevOps Enthusiast

---

## ⭐ Support

If you found this useful, consider giving it a star ⭐ on GitHub!


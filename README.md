# AWS Cloud Threat Detection & Response Lab

This project demonstrates threat detection and automated response capabilities in AWS using services like **GuardDuty**, **Security Hub**, **AWS Config**, **CloudTrail**, and **Lambda**. It is built entirely using **Terraform** and is designed to simulate real-world security incidents, detect them, and respond automatically.

## 🛡️ Goal

Showcase practical cloud security engineering skills for identifying, monitoring, and remediating cloud threats using AWS native tools and Infrastructure as Code (IaC).

---

## 🔧 Tools & Services Used

- **AWS Services**: EC2, VPC, GuardDuty, Security Hub, CloudTrail, Config, IAM, Lambda, S3
- **Terraform**: Infrastructure provisioning
- **Python (Boto3)**: Used in Lambda functions for automated response
- **MITRE ATT&CK**: Threat simulation alignment (optional)
- **CloudWatch**: Event rules to trigger remediation actions

---

## 🧰 Features

### ✅ Infrastructure as Code (Terraform)
- Creates an isolated VPC with public subnet and EC2 instance ("threat target")
- Enables CloudTrail, GuardDuty, and Security Hub
- Attaches IAM roles with least-privilege access for services

### 🔎 Threat Simulation
- Simulate suspicious activity such as:
  - **Port scanning**
  - **Brute-force login attempts**
  - **Unencrypted or public S3 buckets**

### ⚠️ Detection
- AWS **GuardDuty** detects the threat and generates a finding
- **Security Hub** aggregates findings across services
- **AWS Config** flags non-compliant resource configurations

### 🚨 Automated Response
- **Lambda** triggered by GuardDuty/CloudWatch event
- Lambda isolates compromised EC2 (e.g., removes public access, adds "quarantine" tag)
- Optional: SNS notification for alerts

---

## 📁 Project Structure

```

aws-threat-detection-lab/
├── terraform/
│   ├── main.tf
│   ├── lambda.tf          
│   ├── variables.tf
│   ├── outputs.tf
├── lambda/
│   └── isolate_instance.py
├── attack_simulation/
│   └── nmap_scan.md
├── diagrams/
│   └── architecture.png
├── README.md
└── .gitignore

````

---

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured with access
- A valid EC2 key pair in your AWS account

### Deployment

1. Clone the repo:
    ```bash
   git clone https://github.com/N0-R4NS0M/aws-threat-detection-lab.git
   cd aws-threat-detection-lab/terraform
    ````

2. Update `variables.tf` with your AWS region and SSH key name

3. Deploy:

   ```bash
   terraform init
   terraform apply
   ```

4. SSH into the EC2 instance and simulate a threat (e.g., using `nmap` or a basic port scan)

---

## 📷 Screenshots (add these later)

* GuardDuty findings
* Security Hub compliance summary
* Auto-tagged and quarantined EC2
* Architecture diagram

---

## 🧠 Learning Outcomes

* Automated threat detection in AWS environments
* Use of GuardDuty, Config, and Security Hub in a practical workflow
* Writing event-driven Lambda responders in Python
* Infrastructure as Code (Terraform) in a security-first architecture
* Compliance monitoring (e.g., unencrypted S3 or wide-open security groups)

---

## 📌 Author

**Aaron Diaz**
[LinkedIn](https://linkedin.com/in/aaron918)

---

## 📝 License

This project is for educational and portfolio use. No warranties, use at your own risk.

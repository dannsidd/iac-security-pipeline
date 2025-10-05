## 🚀 Project Overview

**SecureS3Ops** is a complete **Infrastructure-as-Code (IaC)** project designed to **automate the creation of secure and compliant AWS S3 buckets** using **Terraform**, fully integrated with a **GitLab CI/CD pipeline**.

This project demonstrates:
- How to implement **secure S3 configurations** (encryption, versioning, access logging).
- How to set up **automated deployments** via **GitLab CI/CD**.
- How to follow **DevSecOps best practices** for cloud resource management.

---

## 🧠 Key Features

✅ Encrypted S3 buckets using AES-256  
✅ Access logging with dedicated log buckets  
✅ Versioning enabled for both buckets  
✅ Public access blocked by default  
✅ Randomized bucket names to prevent duplication  
✅ Fully automated Terraform workflow (init → plan → apply)  
✅ GitLab CI/CD integration for zero-touch deployment  

---

## 🧩 Tech Stack

| Component        | Description                                   |
|------------------|-----------------------------------------------|
| **Terraform**    | IaC tool to provision AWS resources           |
| **AWS S3**       | Cloud storage service for buckets             |
| **GitLab CI/CD** | Pipeline for automated deployment             |
| **Checkov**      | Security scanning tools for IaC               |

---

## 🛠️ Step-by-Step Implementation

### **Step 1 — Project Setup**
- Initialized a new GitLab repository: `iac-security-pipeline`
- Created project structure:
```

.
├── main.tf
├── variables.tf
├── outputs.tf
├── .gitlab-ci.yml
└── README.md

```

---

### **Step 2 — Configure AWS Credentials**
- Added AWS credentials securely under **GitLab → Settings → CI/CD → Variables**  
```

AWS_ACCESS_KEY_ID     = <your-access-key>
AWS_SECRET_ACCESS_KEY = <your-secret-key>

````
- Both variables were **masked** and **protected** for security.

---

### **Step 3 — Define Terraform Infrastructure**
Created a Terraform configuration (`main.tf`) that provisions:
- A **log bucket** for S3 access logs.
- A **secure bucket** with encryption, versioning, and public access blocking.
- A **randomized name** for uniqueness.


---

### **Step 4 — Build the CI/CD Pipeline**

Configured `.gitlab-ci.yml` to automate:

* **Terraform install**
* **Init → Plan → Apply** stages
* **Infrastructure deployment**


---

### **Step 5 — Troubleshooting & Fixes**


* Verified successful run with ✅ **green pipeline** in GitLab.

---

### **Step 6 — Successful Deployment**

* Terraform created both S3 buckets successfully.
* All AWS resources visible in the AWS Management Console.
* CI/CD pipeline now automates infrastructure provisioning end-to-end.

---

## 📸 Pipeline Snapshot

| Stage             | Status    | Description                     |
| ----------------- |-----------| ------------------------------- |
| `terraform_init`  | ✅ Passed | Terraform initialized           |
| `terraform_plan`  | ✅ Passed | Plan generated                  |
| `terraform_apply` | ✅ Passed | S3 buckets created successfully |

---

## 🔐 Security Best Practices Followed

* No hardcoded credentials
* Encrypted data at rest (AES256)
* Bucket versioning enabled
* Public access completely blocked
* Centralized access logging

---

## 🧾 Outputs

After successful apply, Terraform outputs:

```
bucket_name = "my-secure-iac-bucket-xxxxxxx"
bucket_arn  = "arn:aws:s3:::my-secure-iac-bucket-xxxxxxx"
```

---


## 💡 Future Enhancements

* Integrate **Checkov** for IaC security scanning
* Add **Slack notifications** on pipeline status
* Store Terraform **remote state in S3 backend**
* Expand infrastructure (EC2, IAM roles, etc.)

---

## 👨‍💻 Author

**Dann Sidd**
DevSecOps Engineer | Cloud Automation 

🌐 *"Automating Cloud Security, One Pipeline at a Time."*

---

## 🏷️ License

This project is licensed under the **MIT License** — feel free to use and modify it for learning or professional use.

```
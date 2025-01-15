# Policy as Code - DevSecOps Implementation with Ansible

## **Introduction**
**Policy as Code** is a method of defining and enforcing security and compliance rules programmatically. These rules, or policies, ensure that organizational standards are consistently applied to IT resources like S3 buckets, EC2 instances, and IAM users.

For example, a policy may require that all S3 buckets have versioning enabled to prevent accidental data loss. Instead of manually enforcing this policy, **PaC automates the process**, making it scalable and error-free.

---

## **Why Policy as Code?**

### **Challenges Without PaC**:
1. **Security Risks**:
   - A public S3 bucket could expose sensitive organizational data.
2. **Manual Enforcement**:
   - Manually applying policies to hundreds of resources is error-prone.
3. **Inconsistencies**:
   - Some resources might not comply with organizational policies.

### **Benefits of PaC**:
- **Automation**: Ensures consistent application of policies.
- **Scalability**: Easily handles hundreds or thousands of resources.
- **Repeatability**: Policies are version-controlled and reusable.

---

## **Implementation with Ansible**

This section demonstrates how to use Ansible to enforce a policy requiring versioning on all S3 buckets in an AWS account.

## Prerequisites

### System Setup
1. **Python**:
   Install Python (if not already installed):
   ```bash
   sudo apt update
   sudo apt install python3 python3-pip -y
   ```

2. **Ansible**:
   Install Ansible using pip:
   ```bash
   pip install ansible
   ```

### AWS CLI Configuration
1. Install the AWS CLI:
   ```bash
   pip install awscli
   ```

2. Configure the AWS CLI with your credentials:
   ```bash
   aws configure
   ```
   Provide:
   - **AWS Access Key ID**
   - **AWS Secret Access Key**
   - **Default Region** (e.g., `us-east-1`)

### Required Installations
1. Install `boto3`, the Python SDK for AWS:
   ```bash
   pip install boto3
   ```

2. Install the Ansible AWS collection:
   ```bash
   ansible-galaxy collection install amazon.aws
   ```

---

## Test Setup with S3 Buckets
If you don’t have existing S3 buckets, create some to test the policy enforcement.

### Create S3 Buckets
Run the following AWS CLI commands:
```bash
aws s3 mb s3://test-bucket-policy-1
aws s3 mb s3://test-bucket-policy-2
aws s3 mb s3://test-bucket-policy-3
```

---

## Write the Ansible Playbook
Create a file named **`enable_s3_versioning.yml`**. This playbook will:
1. List all S3 buckets in your AWS account.
2. Loop through the buckets and enable versioning on each bucket.

---

## Run the Ansible Playbook

### Command to Execute
Run the playbook using the `ansible-playbook` command:
```bash
ansible-playbook enable_s3_versioning.yml
```

### Execution Steps
1. **List S3 Buckets**:
   - The `amazon.aws.s3_bucket_info` module fetches all buckets in the account and saves the details into a variable called `result`.

2. **Enable Versioning**:
   - The `loop` iterates through `result.buckets`.
   - For each bucket, the `amazon.aws.s3_bucket` module enables versioning.

---

## Verify the Implementation
1. Log in to your **AWS Management Console**.
2. Navigate to **S3** and check the properties of each bucket.
3. Confirm that **Versioning** is now marked as **Enabled**.

---

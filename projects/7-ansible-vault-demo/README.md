# Ansible Vault: Enhancing Playbook Security for DevOps Workflows

## **Prerequisites**

### Install Required Tools
1. **Install Ansible**:
   ```bash
   sudo apt update && sudo apt install ansible -y  # For Ubuntu/Debian
   ```
2. **Install AWS SDK for Python (`boto3`)**:
   ```bash
   pip install boto3
   ```
3. **Install AWS Ansible Collection**:
   ```bash
   ansible-galaxy collection install amazon.aws
   ```

---

## **Create an Encrypted File for AWS Credentials**

Encrypt the AWS credentials file:
```bash
ansible-vault encrypt aws_credentials.yml
```

---

## **Run the Playbook**

1. Execute the playbook using the Vault password:
   ```bash
   ansible-playbook launch_ec2.yml --ask-vault-pass
   ```
   - You will be prompted to enter the Vault password to decrypt the credentials file.

2. Use a password file for automation:
   - Create a file `vault.pass` containing the Vault password:
     ```bash
     echo "YOUR_VAULT_PASSWORD" > vault.pass
     ```
   - Run the playbook without manual password input:
     ```bash
     ansible-playbook launch_ec2.yml --vault-password-file vault.pass
     ```

---

## **Verify the Results**

1. Log in to your AWS Management Console.
2. Navigate to **EC2 Instances** and confirm that the instance has been created.

---

## **Best Practices**

### Password Management
- Use strong, randomly generated passwords (e.g., via `openssl`):
  ```bash
  openssl rand -base64 32 > vault.pass
  ```
- Store passwords in secret management systems:
  - **AWS Secrets Manager**
  - **Azure Key Vault**
  - **HashiCorp Vault**
- Restrict access to the password file:
  ```bash
  chmod 600 vault.pass
  ```

### Environment-Specific Vault Passwords
- Use different passwords for environments like `dev`, `staging`, and `production`.
- Example setup:
  - `dev_vault.pass` for development.
  - `staging_vault.pass` for staging.
  - `prod_vault.pass` for production.

### Automate Vault Password Management
- Integrate Ansible Vault with secret management solutions to reduce manual intervention.






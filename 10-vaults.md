# Secure Ansible Playbooks using Vault

## **What is Ansible Vault?**

Ansible Vault is a built-in tool for securing sensitive data such as passwords, API tokens, and credentials in playbooks or roles. 

### **Why Use Ansible Vault?**
- **Security**: Protect sensitive data from being exposed when sharing playbooks.
- **Compliance**: Meets security standards for handling sensitive information.
- **Convenience**: Comes pre-installed with Ansible, requiring no additional setup.

---

## **Key Commands**

### **Encryption**
1. **Create and Encrypt a New File**
   ```bash
   ansible-vault create <file_name>
   ```
   Prompts for a password and opens the file for editing.

2. **Encrypt an Existing File**
   ```bash
   ansible-vault encrypt <file_name>
   ```

3. **Encrypt a String**
   ```bash
   ansible-vault encrypt_string '<string>' --name '<variable_name>'
   ```

### **Decryption**
1. **Decrypt an Encrypted File**
   ```bash
   ansible-vault decrypt <file_name>
   ```

2. **View Encrypted Content**
   ```bash
   ansible-vault view <file_name>
   ```

### **Editing Encrypted Files**
1. **Modify Encrypted Content**
   ```bash
   ansible-vault edit <file_name>
   ```

### **Using Password Files**
To avoid entering passwords manually:
```bash
ansible-vault <command> <file_name> --vault-password-file <password_file>
```

---

## **How Ansible Vault Works**

Ansible Vault secures data by encrypting files or strings with a password. Without the correct password, encrypted content appears as scrambled text. 

Example encrypted file:
```yaml
$ANSIBLE_VAULT;1.1;AES256
616263646566676869...
```

---

## **Practical Example: Securing AWS Credentials**

1. Create a file to store AWS credentials:
   ```yaml
   ec2_access_key: <your_access_key>
   ec2_secret_key: <your_secret_key>
   ```

2. Encrypt the file:
   ```bash
   ansible-vault create aws_credentials.yml
   ```

3. Reference encrypted variables in a playbook:
   ```yaml
   - name: Launch EC2 instance
     hosts: localhost
     tasks:
       - name: Use credentials
         aws_ec2:
           aws_access_key: "{{ ec2_access_key }}"
           aws_secret_key: "{{ ec2_secret_key }}"
   ```

---

## **Best Practices**

### **Passwords**
- Use strong passwords (e.g., `openssl rand -base64 32`).
- Store passwords securely using services like:
  - AWS Secrets Manager
  - Azure Key Vault
  - HashiCorp Vault

### **Password Management Strategy**
- Use different passwords for each environment (e.g., dev, staging, production).
- Restrict access to production passwords.
- Automate password management by integrating with a secret management solution.
- Regularly rotate passwords for enhanced security.
- Limit access to vault passwords using IAM roles or similar tools.



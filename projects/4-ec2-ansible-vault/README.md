# Secure AWS Resource Provisioning Using Ansible and Vault

Creating an EC2 instance on AWS using Ansible with proper configurations, including variables, Ansible Vault, and collections.

## Step 1: Prerequisites

```bash
# Access Key ID and Secret Access Key for an IAM user with EC2 permissions required.

# Install Ansible on your control node (local machine or EC2 instance):
sudo apt update
sudo apt install ansible -y

# Install the AWS collection:
ansible-galaxy collection install amazon.aws

# Install the boto3 Python library:
pip install boto3
```

## Step 2: Directory Structure

```bash
project/
├── playbook.yml       # Main Playbook
├── inventory.ini      # Inventory file
├── group_vars/
│   └── all.yml        # Group-wide variables
├── roles/
│   └── ec2/
│       ├── tasks/
│       │   └── main.yml       # Task to create EC2
│       ├── defaults/
│       │   └── main.yml       # Default variables
│       └── vars/
│           └── main.yml       # Variables (if needed)
└── vault/
    └── secrets.yml    # Encrypted credentials
```

## Step 3: Create a Vault file to securely store AWS credentials:

`ansible-vault create vault/secrets.yml --vault-password-file vault.pass`

Add the following content (replace with your AWS keys):

```yaml
AWS_ACCESS_KEY: YOUR_ACCESS_KEY
AWS_SECRET_KEY: YOUR_SECRET_KEY
```

## Step 4: Run the Playbook

```bash
# Test the Playbook without making changes:
ansible-playbook -i inventory.ini playbook.yml --check

# Execute the Playbook, passing the Vault password file:
ansible-playbook -i inventory.ini playbook.yml --vault-password-file vault.pass

# Verify: Navigate to the EC2 Dashboard and check for the newly created instance.
```
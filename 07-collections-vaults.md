## 1. Ansible Collections

Ansible Collections are pre-packaged bundles of modules, roles, and plugins to manage specific tools or platforms, such as AWS, Kubernetes, or Cisco.

**How Ansible Interacts with Systems**

- Built-in modules like `apt`, `file`, or `copy` execute directly on managed nodes (e.g., EC2 instances via SSH).

- Instead of directly connecting to virtual machines, collections (e.g., AWS) enable Ansible to interact with third-party APIs to create and manage resources. 

    - AWS APIs: Used to create resources like EC2 instances or S3 buckets.

    - Kubernetes APIs: Used to manage clusters.

**To create or manage AWS resources (like EC2 instances or S3 buckets) programmatically without direct SSH access.**

```bash
# Install the collection using:
ansible-galaxy collection install amazon.aws

# Install Python’s boto3 library on the control node (required for AWS API communication):
pip install boto3`

# Use the AWS documentation to find supported modules (e.g., ec2_instance, s3_bucket).
```

## 2. Creating an EC2 Instance

Creating an EC2 instance using the ec2_instance module from the AWS collection.

**Playbook Example**

- Hosts: Set to localhost since the control node will execute the tasks.

- Connection: Use local since the tasks are executed locally, not on managed nodes.

- Task: Call he `ec2_instance` module to create an EC2 instance.

```yaml
---
- hosts: localhost
  connection: local
  tasks:
    - name: Launch EC2 instance
      amazon.aws.ec2_instance:
        instance_type: t2.micro
        image_id: ami-0abcdef1234567890
        region: us-east-1
        aws_access_key: "{{ AWS_ACCESS_KEY }}"
        aws_secret_key: "{{ AWS_SECRET_KEY }}"
```

## 3. Securing AWS Credentials

Storing sensitive data like AWS credentials directly in Playbooks poses a security risk. Ansible Vault provides a way to securely store and manage sensitive data.

```bash
# Generate a Vault Password File:
# Use OpenSSL to create a random password for the Vault.
openssl rand -base64 32 > vault.pass

# Create a Vault file to store secrets:
ansible-vault create secrets.yml --vault-password-file vault.pass
# Add the AWS_ACCESS_KEY and AWS_SECRET_KEY to this `secrets.yml file.
```

Example `secrets.yml`:
```yaml
---
AWS_ACCESS_KEY: YOUR_ACCESS_KEY
AWS_SECRET_KEY: YOUR_SECRET_KEY
```

Reference Vault Variables in the Playbook using Jinja2 templating:
```yaml
---
aws_access_key: "{{ AWS_ACCESS_KEY }}"
aws_secret_key: "{{ AWS_SECRET_KEY }}"
```

Run the Playbook with Vault Password:
```bash
ansible-playbook ec2_create.yml --vault-password-file vault.pass
```
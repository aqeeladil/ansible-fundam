# Automating Cloud Infrastructure Management with Ansible

*Automating repetitive tasks, implementing secure authentication, and managing resources efficiently using Ansible's core features like loops, conditionals, and playbooks.*

**Scenario: Perform three tasks:**

- Create EC2 instances with Ansible.

- Set up passwordless authentication for those instances.

- Automate the shutdown of specific instances based on conditions.

## Prerequisites

```bash
# Create an IAM user with EC2FullAccess permissions. Get the access key and secret key.

sudo apt install python3 pip ansible -y
pip install boto3 botocore -y

# Install the AWS collection:
ansible-galaxy collection install amazon.aws
```

## Task 1: Provisioning EC2 Instances

- Create a playbook file `create_ec2.yml`.

    - Create three EC2 instances using Ansible. Two with Ubuntu OS. One with Amazon Linux.

    - Host: Use localhost since the task will run locally.

    - Connection Type: local, because AWS does not use SSH for provisioning.

    - Module: Use amazon.aws.ec2_instance.

    - Handle Idempotency: Ansible ensures no duplicate instances are created if the playbook runs multiple times. To avoid issues (e.g., duplicate names causing skips), ensure unique attributes like instance names.

        - Use loops with distinct variables (e.g., instance names, AMI IDs) to handle repeated tasks and to ensure each task creates a unique instance.

- Create a `vars.yml` file with AWS credentials. Encrypt it using Ansible Vault.

    - `ansible-vault encrypt vars.yml`

- Run the Playbook:

    - `ansible-playbook create_ec2.yml --extra-vars "@vars.yml" --ask-vault-pass`

## Task 2: Setting Up Passwordless Authentication

Enable passwordless SSH access to the newly created instances for future configuration management.

- Create an inventory file `inventory.yml`.

- Create a playbook `passwordless_auth.yml`.

- Run the Playbook:

    - `ansible-playbook -i inventory.yml passwordless_auth.yml`

- Verify the connection by logging into the instances without specifying the key file.

    - `ssh ubuntu@<IP_OF_UBUNTU_1>`

    - `ssh ubuntu@<IP_OF_UBUNTU_2>`

    - `ssh ec2-user@<IP_OF_AmazonLinux>`

    - No password prompt should appear.

## Task 3: Automating Shutdown of Ubuntu Instances

Write an Ansible playbook to shut down only the Ubuntu instances based on their operating system.

- Create a playbook `shutdown_instances.yml`.

    - Ansible collects system information (e.g., OS family) during execution. Use this data to differentiate instances.

    - Use Ansible Facts to filter instances based on their OS family.

    - Use shutdown -h now to shut down the target instances.

    - Add a when condition to execute the shutdown command only on instances where os_family is Debian.

- Run the Playbook:

    - `ansible-playbook -i inventory.yml shutdown_instances.yml`

## Verify

Use the AWS Management Console to verify:

- Task 1: Instances are running.

- Task 3: Only the Ubuntu instances are stopped.

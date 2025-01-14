# Setting up threee EC2 instances on AWS using Terraform and then configuring one as the master and the other two as worker nodes using Ansible.

Creates three EC2 instances using Terraform, then configures 

**Initialize and Apply Terraform**
```bash
cd ec2_infrastructure   # move to terraform working directory
terraform init       # Initialize Terraform
terraform apply      # Apply the Terraform plan
```
Once applied, Terraform will output the IPs of the master and worker nodes.

**Run the Ansible Playbook**
```bash
cd ec2_configuration      # move to ansible working directory
ansible-playbook -i inventory.ini instances.yml     # run playbook
```


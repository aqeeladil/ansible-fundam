## Passwordless Authentication

Passwordless authentication is a prerequisite for using Ansible effectively. It allows the control node (where Ansible is installed) to communicate with managed nodes (target systems) without repeatedly asking for credentials, enabling true automation.

Without it, each time a command or playbook runs, you’d need to manually provide credentials for each managed node, defeating the purpose of automation.

### Two Methods to Set Up:

- **Using SSH Keys:**

    - Generate a key pair on the control node (public/private keys) using `ssh-keygen`.

    - Copy the public key of the Controller_Node (`.ssh/id_rsa.pub`) to the Target_Node (`.ssh/authorized_keys`) using:

        `ssh-copy-id user@<managed_node_ip>`

    - Once set up, no password is required for communication between the control and managed nodes.

- **Using Password Authentication:**

    - This is less common but works where SSH key access is not configured.

    - Enable password authentication on the managed node by modifying `/etc/ssh/sshd_config`:
        
        `PasswordAuthentication yes`
    
    - Create a passowrd for managed node using : sudo passwd ubuntu

    - Restart the SSH service: `sudo systemctl restart sshd`

    - Use `ssh-copy-id ubuntu@<managed-node-ip>` to copy the public key while providing the managed node's password once to establish trust.

**Outcome:** Once either method is configured, Ansible can execute commands or playbooks on managed nodes without manual intervention.
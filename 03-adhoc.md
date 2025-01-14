# Ad-hoc Commands vs Playbook

Ansible provides two primary ways to run tasks on remote systems: ad hoc commands and playbooks.

## 1. Ad-hoc Commands

An **ad-hoc command** is a one-time command used to perform a quick task without needing a saved file or script. Typically used for simple, immediate tasks that don’t require complex logic or reuse. E.g; Restarting a service or checking the status of a server.

`ansible [host-pattern] -m [module] -a "[arguments]"` 

```bash
# <host-pattern>: Targets like all, a group name, or a specific host.
# <inventory>: Path to the inventory file.
# <module>: Ansible module (e.g., ping, shell, copy).
# <arguments>: Options or instructions passed to the module.

# Ping All Servers:
ansible all -i inventory.ini -m ping

# Run a Shell Command:
ansible all -i inventory.ini -m shell -a "apt update"

# List Files on a Managed Node:
ansible db1 -i inventory.ini -m shell -a "ls /etc"

# Install a Package:
ansible all -i inventory.ini -m apt -a "name=nginx state=present"
```

## 2. Playbook

A **Playbook** is a YAML file that defines a series of tasks to be executed on specified hosts. Playbooks are used to define and orchestrate more complex configurations or deployments. Best suited for complex tasks, configurations, and repetitive processes where logic, conditional execution, and reuse are important.
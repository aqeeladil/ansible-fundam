# Ansible Galaxy

Ansible Galaxy is the official hub for finding community-created pre-built roles and collections, which are essentially pre-defined sets of tasks, variables, and configurations that simplify complex setups.

- **For Example:** If you need to set up an Apache server, you can search Ansible Galaxy for a community role that has pre-defined tasks for installing and configuring Apache. Instead of creating the role from scratch, you install it with ansible-galaxy install and customize it as needed, saving time and effort.

```bash
# Install Roles and Collections
# Installed roles are stored in the ~/.ansible/roles directory by default.
ansible-galaxy install <rolename>
ansible-galaxy collection install <namespace.collection>

# Create New Roles and Collections
ansible-galaxy init <role-name>

# Manage Roles and Collections
ansible-galaxy list
ansible-galaxy remove <role-name>
```

Once installed, you can reference the role in your playbooks.
```yaml
---
- hosts: all
  become: true
  roles:
    - <role-name>
```

## Publishing Roles

If you write your own Ansible role, you can publish it to Ansible Galaxy so others can use it.

**Steps:**

- Create a GitHub repository for the role.

- Push your role files (tasks, defaults, meta information, etc.) to the repository.

- Import the role into Ansible Galaxy using the ansible-galaxy import command.

- Optionally, update the role’s README.md file and metadata (meta/main.yml) for clarity.

```bash
git init
git remote add origin https://github.com/yourusername/yourrole.git
git add .
git commit -m "Initial commit"
git push origin main

ansible-galaxy role import yourusername yourrole --token <API_TOKEN>
```

## Example:

**Install and configure Docker on multiple managed nodes with varying operating systems (Ubuntu, Debian, Red Hat, etc.).**

**Steps:**

Go to Ansible Galaxy and search for "docker." Find a role (e.g., geerlingguy.docker) that supports multiple OS platforms.

```bash
ansible-galaxy role install geerlingguy.docker
```
```yaml
---
- hosts: all
  become: true
  roles:
    - geerlingguy.docker
```
```bash
ansible-playbook -i inventory docker-playbook.yml
```





